#!/usr/bin/env bash
# Usage: bash new-post.sh "Title of the post"
# Creates posts/YYYY-MM-DD-title-of-the-post/index.qmd as a draft.
set -euo pipefail

title="${1:?Usage: bash new-post.sh \"Title of the post\"}"
# Transliterate accents (Erdős -> Erdos) where iconv supports it, then slugify.
ascii=$(printf '%s' "$title" | iconv -f UTF-8 -t ASCII//TRANSLIT 2>/dev/null || printf '%s' "$title")
slug=$(printf '%s' "$ascii" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')
today=$(date +%Y-%m-%d)
dir="posts/${today}-${slug}"

if [ -e "$dir" ]; then
  echo "Already exists: $dir" >&2
  exit 1
fi

mkdir -p "$dir"
cat > "$dir/index.qmd" <<POST
---
title: "$title"
description: ""
date: $today
categories: []
draft: true
---

{{< include /_macros.qmd >}}

POST

echo "Created $dir/index.qmd"
echo "It's a draft: visible in 'quarto preview', hidden on the published site until you delete 'draft: true'."
