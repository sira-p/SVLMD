#!/bin/sh

file="build/index.html"

title="Sira's Very Large Medical Database (SVLMD)"
description="A community-maintained, expert-reviewed, non-hierarchical medical education database. It prioritizes Thai medical context."
image="assets/social-preview.png"

# Escape HTML characters
title_escaped=$(echo "$title" | sed 's/&/\&amp;/g; s/"/\&quot;/g')
description_escaped=$(echo "$description" | sed 's/&/\&amp;/g; s/"/\&quot;/g')

sed -i "s/<meta property=\"og:title\"[^>]*>/<meta property=\"og:title\" content=\"$title_escaped\">/" "$file"
sed -i "s/<meta property=\"og:description\"[^>]*>/<meta property=\"og:description\" content=\"$description_escaped\">/" "$file"
sed -i "s/<meta name=\"description\"[^>]*>/<meta name=\"description\" content=\"$description_escaped\">/" "$file"
sed -i "s#[[:space:]]*<meta content=\"[^\"]*\" property=\"og:image\">#<meta content=\"$image\" property=\"og:image\">#" "$file"
echo "Inject HTML: Replaced meta."

script='<script>
  document.title = document.title + " | SVLMD";
</script>'

# Escape for sed insertion
escaped=$(echo "$script" | sed 's/[&\\]/\\&/g; s/\//\\\//g' | sed ':a;N;$!ba;s/\n/\\n/g')

# Inject before </body>
sed -i "s#</body>#$escaped\n</body>#" "$file"
echo "Inject HTML: Injected title-replacing script."
