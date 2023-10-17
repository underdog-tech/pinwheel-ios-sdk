#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

source ./scripts/helpers.sh

set_up_github_user

VERSION=$(grep -E 's.version[[:space:]]*=' PinwheelSDK.podspec | sed -E "s/.*['\"]([^'\"]+)['\"].*/\1/")

echo \>\> Version: $VERSION

TAG_EXISTS=$(git tag -l "$VERSION")

if [ -n "$TAG_EXISTS" ]; then
  echo Version tag \"$VERSION\" already exists in Github. Exiting before Cocoapod publishes.
  circleci-agent step halt
else
  # Add new tag
  git tag "$VERSION"
  git push authenticated --tags
fi
