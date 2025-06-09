#!/bin/sh

meta="<meta property=\"og:title\" content=\"Sira's Very Large Medical Database (SVLMD)\">
<meta name=\"description\" content=\"Sira's Very Large Medical Database (SVLMD) is a community-maintained, expert-reviewed, non-hierarchical medical education database. The information prioritizes demographics, geography, and socioeconomy in the context of Thailand.\">
<meta property=\"og:description\" content=\"Sira's Very Large Medical Database (SVLMD) is a community-maintained, expert-reviewed, non-hierarchical medical education database. The information prioritizes demographics, geography, and socioeconomy in the context of Thailand.\">
<meta property=\"og:image\" content=\"/static/img/SVLMD-logo.svg\">"

script='<script>
  document.title = document.title + " | SVLMD";
</script>'

file="$GITHUB_WORKSPACE/build/index.html"

injection="$meta
$script"

# Escape newlines and backslashes for safe sed insertion
escaped=$(echo "$injection" | sed 's/[&/\]/\\&/g' | sed ':a;N;$!ba;s/\n/\\n/g')

sed -i "/<\/head>/i $escaped" "$file"
