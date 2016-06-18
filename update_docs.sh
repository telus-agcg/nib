#! /bin/bash

echo "
# Supported Commands

The following commands are available:
" > docs/commands.md

template='
  .[] | "\n### `\(.name)`\n\n\(.short_description)\n\n\(.long_description)\n"
'
cat config/commands.json | jq -r "$template" >> docs/commands.md
