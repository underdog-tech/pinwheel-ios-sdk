#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

source ./scripts/helpers.sh

set_up_github_user

# Configuration
REPO_OWNER="underdog-tech"
REPO_NAME="pinwheel-ios-sdk"
GITHUB_TOKEN=$GITHUB_PR_ACCESS_TOKEN
VERSION=$(get_version)
TARGET_BRANCH="master"

# Get the current branch name
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Exit if not on the 'master' branch
if [ "$CURRENT_BRANCH" != "master" ]; then
    echo "You are not on the 'master' branch. Exiting..."
    exit 0
fi

# Check if there are changes
if [ -z "$(git status --porcelain)" ]; then
    echo "No changes detected. PR not required..."
    exit 0
else
  BRANCH_NAME="release-$VERSION"
  # Check out a new branch named after the version
  git checkout -b $BRANCH_NAME

  # Get the added lines to the change log and make them the PR description
  CHANGELOG_DIFF=$(git diff CHANGELOG.md | grep '^+[^+]' | sed 's/^[ \t+-]*//')

  git add .
  git commit -m "Release $VERSION"

  # Push the new branch to GitHub
  git push authenticated $BRANCH_NAME

  # Use the GitHub API to create the PR
  curl -X POST \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/pulls \
    -d '{
      "title": "Release '$VERSION'",
      "head": "'"$VERSION"'",
      "base": "'"$TARGET_BRANCH"'",
      "body": "'"$CHANGELOG_DIFF"'"
    }'
fi