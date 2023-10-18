#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

source ./scripts/helpers.sh

set_up_github_user

VERSION=$(get_version)

echo \>\> Version: $VERSION

TAG_EXISTS=$(git tag -l "$VERSION")

if [ -n "$TAG_EXISTS" ]; then
  echo Version tag \"$VERSION\" already exists in Github. Exiting before Cocoapod publishes.
  circleci-agent step halt
else
  echo \>\> Tagging with: $VERSION
  # Add new tag
  git tag "$VERSION"
  echo \>\> Pushing tag
  git push authenticated --tags

  # Create release for tag
  echo \>\> Creating release for tag $VERSION
  curl -X POST -H "Authorization: token $(get_github_write_token)" \
     -H "Accept: application/vnd.github.v3+json" \
     "https://api.github.com/repos/$(get_repo_owner)/$(get_repo_name)/releases" \
     -d '{
         "tag_name": "'"${VERSION}"'",
         "target_commitish": "master",
         "name": "'"${VERSION}"' Release",
         "body": "Release pinwheel-ios-sdk '"${VERSION}"'",
         "draft": false,
         "prerelease": false
     }'

fi
