#!/bin/sh

RUN_ID=$(gh -R UnchartedBull/OctoDash run list -b plugin-migration -w CI -L 1 --json name,number,databaseId -q '.[0].databaseId')

gh -R UnchartedBull/OctoDash run download $RUN_ID
