#!/bin/bash

# Script to list comments on PR files using GitHub API
# Usage: ./pr-file-comments.sh <PR_NUMBER>
# 
# This script fetches review comments (line-specific code comments) from a GitHub PR
# and returns structured data showing files, line numbers, code context, and comments.
# Output is designed to be easily consumed by Claude for rule processing.

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <PR_NUMBER>"
    echo "Example: $0 5"
    exit 1
fi

PR_NUMBER="$1"

# Validate PR number is numeric
if ! [[ "$PR_NUMBER" =~ ^[0-9]+$ ]]; then
    echo "Error: PR number must be numeric"
    exit 1
fi

# Get repository info from git remote
REPO_INFO=$(gh repo view --json owner,name)
OWNER=$(echo "$REPO_INFO" | jq -r '.owner.login')
REPO=$(echo "$REPO_INFO" | jq -r '.name')

if [ "$OWNER" = "null" ] || [ "$REPO" = "null" ]; then
    echo "Error: Could not determine repository owner/name"
    exit 1
fi

echo "# PR #$PR_NUMBER File Comments Report"
echo "Repository: $OWNER/$REPO"
echo "Generated: $(date)"
echo ""

# Fetch review comments using gh api
COMMENTS=$(gh api "repos/$OWNER/$REPO/pulls/$PR_NUMBER/comments" --jq '
  group_by(.path) | 
  map({
    file: .[0].path,
    comments: map({
      id: .id,
      line: .line,
      original_line: .original_line,
      side: .side,
      start_line: .start_line,
      original_start_line: .original_start_line,
      diff_hunk: .diff_hunk,
      body: .body,
      user: .user.login,
      created_at: .created_at,
      updated_at: .updated_at,
      in_reply_to_id: .in_reply_to_id
    })
  })
')

# Check if any comments were found
if [ "$(echo "$COMMENTS" | jq 'length')" = "0" ]; then
    echo "No file comments found on PR #$PR_NUMBER"
    exit 0
fi

# Process and display comments grouped by file
echo "$COMMENTS" | jq -r '
  .[] | 
  "## File: " + .file + "\n" +
  (.comments | map(
    "### Comment #" + (.id | tostring) + 
    (if .in_reply_to_id then " (Reply to #" + (.in_reply_to_id | tostring) + ")" else "" end) + "\n" +
    "**User:** " + .user + "\n" +
    "**Line:** " + (.line | tostring) + 
    (if .start_line and .start_line != .line then "-" + (.start_line | tostring) else "" end) + "\n" +
    "**Side:** " + .side + "\n" +
    "**Created:** " + .created_at + "\n" +
    (if .updated_at != .created_at then "**Updated:** " + .updated_at + "\n" else "" end) +
    "\n**Diff Context:**\n```diff\n" + .diff_hunk + "\n```\n" +
    "\n**Comment:**\n" + .body + "\n"
  ) | join("\n---\n\n")) + "\n"
'

echo ""
echo "---"
echo "Total files with comments: $(echo "$COMMENTS" | jq 'length')"
echo "Total comments: $(echo "$COMMENTS" | jq '[.[].comments | length] | add')"