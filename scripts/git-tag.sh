#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

git config user.email "pinwheel-it@pinwheelapi.com"
git config user.name "pinwheel-it-svc"

VERSION=$(grep -E 's.version[[:space:]]*=' PinwheelSDK.podspec | sed -E "s/.*['\"]([^'\"]+)['\"].*/\1/")

echo $VERSION

# Add the remote with the access token
git remote add authenticated https://pinwheel-it-svc:${GITHUB_ACCESS_TOKEN}@github.com/underdog-tech/pinwheel-ios-sdk.git

# Delete old tag (otherwise new tagging will fail)
git tag -d "$VERSION" || echo Ignore error, no previous tag named \"$VERSION\" to delete

# Add new tag
git tag "$VERSION"

# Push the tag (need force so old tag is overwritten)
git push -f authenticated --tags
