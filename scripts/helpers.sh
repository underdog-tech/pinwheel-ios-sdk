#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

function get_alpha_val () {
  # The following logic allows us to run the same job in circle regardless of branch
  # If IS_ALPHA is not already set...
  if [ -z "$IS_ALPHA" ]; then
    # If current branch is master...
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$current_branch" != "master" ]; then
      # Set alpha to true. This is relevant for setting alpha by default on non-master branches in our CI.
      IS_ALPHA=true
    else
      IS_ALPHA=false
    fi
  fi

  echo $IS_ALPHA
}

function get_version () {
  echo $(grep -E 's.version[[:space:]]*=' PinwheelSDK.podspec | sed -E "s/.*['\"]([^'\"]+)['\"].*/\1/")	
}

function set_up_github_user () {
  git config user.email "pinwheel-it@pinwheelapi.com"
  git config user.name "pinwheel-it-svc"
  git remote | grep "authenticated" || git remote add authenticated https://pinwheel-it-svc:${GITHUB_ACCESS_TOKEN}@github.com/underdog-tech/pinwheel-ios-sdk.git
}
