#!/bin/bash

source env.sh

common_opt=""

start_fmt=$(date +%Y-%m-%d\ %r)
echo "STARTING RUN AT $start_fmt"

cd /mlperf/inference/v0.5/classification_and_detection
python3 python/main.py $opts

end_fmt=$(date +%Y-%m-%d\ %r)
echo "ENDING RUN AT $end_fmt"
