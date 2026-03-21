#!/bin/sh

DEFAULT_BRANCH=main

BRANCH=${1:-$DEFAULT_BRANCH}

rm -r artifacts/*
mkdir -p artifacts

RUN=$(gh -R UnchartedBull/OctoDash run list -b $BRANCH -w CI -L 1 --json name,number,databaseId,status | jq -r '.[0]')
if [  "$RUN" == "null" ]; then
  echo "No runs found for branch $BRANCH"
  exit 1
fi
if [ "$(echo $RUN | jq -r '.status')" != "completed" ]; then
  echo "Latest run for branch $BRANCH is not completed"
  exit 1
fi

RUN_ID=$(echo $RUN | jq -r '.databaseId')


INFO=$(gh api /repos/UnchartedBull/OctoDash/actions/runs/$RUN_ID/artifacts | jq '.artifacts[]  | select(.name | contains(".whl"))')
NAME=$(echo $INFO | jq -r '.name')
URL=$(echo $INFO | jq -r '.archive_download_url')
echo "Downloading $NAME"

gh api $URL > artifacts/$NAME
