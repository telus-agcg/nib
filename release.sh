#! /bin/bash

# delete local "latest" tag
git tag -d latest

# delete remote "latest" tag
git push origin :refs/tags/latest

# tag current commit with "latest"
git tag latest

# tag with version from VERSION
git tag $(cat VERSION)

# push to origin
git push origin master --tag
