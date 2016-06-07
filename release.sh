#! /bin/bash

# update commands document
docker run \
  --rm \
  -v $PWD:/usr/src/app \
  -w /usr/src/app \
  --entrypoint=./update_docs.sh \
  technekes/nib

# fail release if commands changed (need to commit first)
if [[ $(git status | grep docs/commands.md) ]]; then
  echo "ERROR:

The commands document (docs/commands.md) has been updated. \
Please commit the changes and try again."

  exit 1
fi

NIB_VERSION=$(cat VERSION)
LATEST=$(curl --silent https://raw.githubusercontent.com/technekes/nib/latest/VERSION)

if [[ $(git status | grep VERSION) ]]; then
  echo "ERROR:

The VERSION file has changed but not been committed. \
Please commit the changes and try again."

  exit 1
elif [ "$NIB_VERSION" == "$LATEST" ]; then
  echo "ERROR:

Please update the VERSION file, it currently matches the previous release"

  exit 1
fi

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
