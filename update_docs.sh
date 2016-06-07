#! /bin/bash

echo "# Supported Commands" > docs/commands.md
echo "
The following commands are available:

Name | Description
---- | -----------" >> docs/commands.md

cat config/commands.json | \
  jq -r '.[] | "`\(.name)` | \(.description)"' \
  >> docs/commands.md
