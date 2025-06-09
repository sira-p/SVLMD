#!/bin/sh

file="build/index.html"

# Delete matching meta tags
sed -i '/<meta[^>]*property=["'\'']og:title["'\'']/d' "$file"
sed -i '/<meta[^>]*property=["'\'']og:description["'\'']/d' "$file"
sed -i '/<meta[^>]*name=["'\'']description["'\'']/d' "$file"
sed -i '/<meta[^>]*property=["'\'']og:image["'\'']/d' "$file"

meta="<meta property=\"og:title\" content=\"Sira's Very Large Medical Database (SVLMD)\">
<meta name=\"description\" content=\"Sira's Very Large Medical Database (SVLMD) is a community-maintained, expert-reviewed, non-hierarchical medical education database. The information prioritizes demographics, geography, and socioeconomy in the context of Thailand.\">
<meta property=\"og:description\" content=\"Sira's Very Large Medical Database (SVLMD) is a community-maintained, expert-reviewed, non-hierarchical medical education database. The information prioritizes demographics, geography, and socioeconomy in the context of Thailand.\">
<meta property=\"og:image\" content=\"assets/banner.png\">"

script='<script>
  document.title = document.title + " | SVLMD";
</script>'

injection="$meta
$script"

# Escape newlines and backslashes for safe sed insertion
escaped=$(echo "$injection" | sed 's/[&/\]/\\&/g' | sed ':a;N;$!ba;s/\n/\\n/g')

sed -i "/<\/head>/i $escaped" "$file"
