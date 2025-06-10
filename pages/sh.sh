#!/bin/bash

# Function to process a single markdown file
process_file() {
    local file="$1"
    local temp_file=$(mktemp)
    local modified=false

    while IFS= read -r line; do
        # Check if line contains "- " followed by hashtags, allowing for leading whitespace
        if [[ $line =~ ^[[:space:]]*-[[:space:]]+#{1,} ]]; then
            # Extract everything up to and including "- " (preserving all whitespace)
            prefix=$(echo "$line" | grep -o '^[[:space:]]*-[[:space:]]*')
            # Get the rest of the line after the prefix
            rest=$(echo "$line" | sed "s/^[[:space:]]*-[[:space:]]*//")

            # Count leading hashtags
            hashtag_count=$(echo "$rest" | grep -o '^#*' | tr -d '\n' | wc -c)

            if [[ $hashtag_count -gt 1 ]]; then
                # Reduce hashtags by 1
                new_hashtags=$(printf '#%.0s' $(seq 1 $((hashtag_count - 1))))
                content_after_hashtags=$(echo "$rest" | sed 's/^#*//')
                new_line="${prefix}${new_hashtags}${content_after_hashtags}"
                echo "$new_line" >> "$temp_file"
                modified=true
            else
                echo "$line" >> "$temp_file"
            fi
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$file"

    if [[ $modified == true ]]; then
        mv "$temp_file" "$file"
        echo "✅ Modified: $file"
        return 0
    else
        rm "$temp_file"
        echo "⚪ Not modified: $file"
        return 1
    fi
}

# Main script
modified_count=0
not_modified_count=0

# Check if any markdown files exist
if ! ls *.md 1> /dev/null 2>&1; then
    echo "❌ No markdown files found in current directory."
    exit 0
fi

# Process all markdown files
for file in *.md; do
    if [[ -f "$file" ]]; then
        if process_file "$file"; then
            modified_count=$((modified_count + 1))
        else
            not_modified_count=$((not_modified_count + 1))
        fi
    fi
done

echo ""
echo "📊 Summary:"
echo "✅ Files modified: $modified_count"
echo "⚪ Files not modified: $not_modified_count"
