#\!/bin/bash

# Function to extract frontmatter between --- markers
extract_frontmatter() {
    local file="$1"
    local in_frontmatter=0
    local frontmatter=""
    
    while IFS= read -r line; do
        if [[ "$line" == "---" ]]; then
            if [[ $in_frontmatter -eq 0 ]]; then
                in_frontmatter=1
            else
                break
            fi
        elif [[ $in_frontmatter -eq 1 ]]; then
            frontmatter="${frontmatter}${line}"$'\n'
        fi
    done < "$file"
    
    echo "$frontmatter"
}

# Process all rule files
for file in .claude/rules/*.rule.md; do
    if [[ -f "$file" ]]; then
        echo "=== FILE: $file ==="
        extract_frontmatter "$file"
    fi
done
