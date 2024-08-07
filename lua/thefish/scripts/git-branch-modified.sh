#!/bin/bash
BRANCH="$PROJECT_MAIN_BRANCH"

if [[ -z "$BRANCH" ]]; then
    BRANCH="master"
fi

# echo $BRANCH
# echo $2

if [[ "$1" == "list" ]]; then
    git diff --name-only --diff-filter=ACMR --relative $BRANCH
elif [[ "$1" == "diff" ]]; then
    git diff --diff-filter=ACMR --relative $BRANCH "$2" 
fi

