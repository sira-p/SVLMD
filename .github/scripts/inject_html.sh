#!/bin/sh

file="build/index.html"

title="Sira's Very Large Medical Database (SVLMD)"
description="Sira's Very Large Medical Database (SVLMD) is a community-maintained, expert-reviewed, non-hierarchical medical education database. The information prioritizes demographics, geography, and socioeconomy in the context of Thailand."
image="assets/banner.png"

sed -i 's/<meta property="og:title"[^>]*>/<meta property="og:title" content="$title">/' "$file"
sed -i 's/<meta property="og:description"[^>]*>/<meta property="og:description" content="$description">/' "$file"
sed -i 's/<meta name="description"[^>]*>/<meta name="description" content="$description">/' "$file"
sed -i 's/<meta property="og:image"[^>]*>/<meta property="og:image" content="$image">/' "$file"

# Help me add this script too
script='<script>
  document.title = document.title + " | SVLMD";
</script>'

injection="$meta
$script"

# Escape newlines and backslashes for safe sed insertion
escaped=$(echo "$injection" | sed 's/[&/\]/\\&/g' | sed ':a;N;$!ba;s/\n/\\n/g')