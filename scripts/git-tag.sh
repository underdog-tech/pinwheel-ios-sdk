#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

source ./scripts/helpers.sh

git config user.email "pinwheel-it@pinwheelapi.com"
git config user.name "pinwheel-it-svc"

VERSION=$(grep -E 's.version[[:space:]]*=' PinwheelSDK.podspec | sed -E "s/.*['\"]([^'\"]+)['\"].*/\1/")

echo \>\> Version: $VERSION

# Add the remote with the access token
git remote add authenticated https://pinwheel-it-svc:${GITHUB_ACCESS_TOKEN}@github.com/underdog-tech/pinwheel-ios-sdk.git


if [ "$(get_alpha_val)" == "true" ]; then
  echo \>\> IS_ALPHA is true, we are not on master branch

  # Delete old tag (otherwise new tagging will fail)
  git tag -d "$VERSION" || echo Ignore error, no previous tag named \"$VERSION\" to delete

  # Add new tag
  git tag "$VERSION"

  # Push the tag (need force so old tag is overwritten)
  git push -f authenticated --tags
else
  echo \>\> IS_ALPHA is false, we are on master branch

  # Add new tag
  git tag "$VERSION"
  git push authenticated --tags
fi
