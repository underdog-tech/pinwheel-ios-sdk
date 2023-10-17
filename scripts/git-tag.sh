#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

VERSION=$(grep -E 's.version[[:space:]]*=' PinwheelSDK.podspec | sed -E "s/.*['\"]([^'\"]+)['\"].*/\1/")

echo $VERSION

# Add the remote with the access token
git remote add authenticated https://pinwheel-it-svc:${GITHUB_ACCESS_TOKEN}@github.com/underdog-tech/pinwheel-ios-sdk.git

# Delete the old tag
git tag -d "$VERSION"

# Add new tag
git tag "$VERSION"

# Push the tag
git push authenticated --tags
