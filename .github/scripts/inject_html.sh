#!/bin/sh

meta='<meta property="og:title" content="cyber docs">
<meta name="description" content="cyber docs">
<meta property="og:description" content="cyber docs">
<meta property="og:image" content="/static/img/SVLMD-logo.svg">'

script='<script>
  document.title = document.title + " | SVLMD";
</script>'

file="$GITHUB_WORKSPACE/build/index.html"

injection="$meta
$script"

# Escape newlines and backslashes for safe `sed` insertion
escaped=$(echo "$injection" | sed 's/[&/\]/\\&/g' | sed ':a;N;$!ba;s/\n/\\n/g')

sed -i "/<\/head>/i $escaped" "$file"
