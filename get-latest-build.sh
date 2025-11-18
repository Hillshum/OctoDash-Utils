#!/bin/sh

DEFAULT_BRANCH=main

BRANCH=${1:-$DEFAULT_BRANCH}

rm -r artifacts/*

RUN_ID=$(gh -R UnchartedBull/OctoDash run list -b $BRANCH -w CI -L 1 --json name,number,databaseId -q '.[0].databaseId')

gh -R UnchartedBull/OctoDash run download --dir artifacts $RUN_ID
