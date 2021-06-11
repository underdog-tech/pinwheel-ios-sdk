#!/bin/bash
 set -e
 printf "\nChecking out master branch...\n"
 git checkout master || exit "$?"

 printf "\nUpdating master branch...\n"

 git pull

 printf "\n"
 JIRA_TKTS=""
 INITIAL_COMMIT_MSG=""
 while : ; do
     printf "JIRA Ticket Number (i.e. INT-1643): "
     read JIRA_TKT
     if [[ -z "$JIRA_TKT" ]]; then
         break
     else
         JIRA_TKTS="${JIRA_TKTS}${JIRA_TKT}_"
         INITIAL_COMMIT_MSG="${INITIAL_COMMIT_MSG}[${JIRA_TKT}]"
     fi
 done

 printf "Name: "
 read NAME
 INITIAL_COMMIT_MSG="${INITIAL_COMMIT_MSG} ${NAME}"

 BRANCH_NAME="feature/${JIRA_TKTS}${NAME}"
 git checkout -b "$BRANCH_NAME"
 git commit --allow-empty -m "$INITIAL_COMMIT_MSG"
 git push --set-upstream origin "$BRANCH_NAME"
