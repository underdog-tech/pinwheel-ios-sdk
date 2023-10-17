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


# Add new tag
  git tag "$VERSION"
  git push authenticated --tags || echo Version tag \"$VERSION\" already exists in Github. Exiting before Cocoapod publish. && circleci-agent step halt
