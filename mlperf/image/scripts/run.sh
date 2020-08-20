#!/bin/bash

BASEDIR=$(dirname "$0")
cd $BASEDIR

source env.sh
source run_common.sh

if [ ! -d $OUTPUT_DIR ]; then
    mkdir -p $OUTPUT_DIR
fi

export opts="--config $MLPERF_CONF --profile $profile $common_opt --model $model_path \
    --dataset-path $DATA_DIR --output $OUTPUT_DIR/$name $extra_args $EXTRA_OPS $@"

bash run_helper.sh
