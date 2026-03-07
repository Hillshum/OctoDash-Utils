#!/bin/sh

DEFAULT_BRANCH=main

BRANCH=${1:-$DEFAULT_BRANCH}

rm -r artifacts/*
mkdir -p artifacts

RUN_ID=$(gh -R UnchartedBull/OctoDash run list -b $BRANCH -w CI -L 1 --json name,number,databaseId -q '.[0].databaseId')


INFO=$(gh api /repos/UnchartedBull/OctoDash/actions/runs/$RUN_ID/artifacts | jq '.artifacts[]  | select(.name | contains(".whl"))')
NAME=$(echo $INFO | jq -r '.name')
URL=$(echo $INFO | jq -r '.archive_download_url')
echo "Downloading $NAME"

gh api $URL > artifacts/$NAME
