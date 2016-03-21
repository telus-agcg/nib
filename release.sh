#! /bin/bash

# tag with version from VERSION
git tag $(cat VERSION)

# push to origin
git push origin master --tag
