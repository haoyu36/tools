#!/bin/bash



git clone https://github.com/weaveworks/flagger.git


cp -r flagger/charts/flagger deploy
cp flagger/artifacts/flagger/crd.yaml deploy
cp -r flagger/artifacts/examples .


