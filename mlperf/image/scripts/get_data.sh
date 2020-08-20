#!/bin/bash

source env.sh

mkdir -p ${DATA_DIR}

echo "Downloading dataset..."
wget -q http://images.cocodataset.org/zips/val2017.zip
wget -q http://images.cocodataset.org/annotations/annotations_trainval2017.zip

echo "Extracting dataset..."
mkdir -p /tmp/coco
unzip -q val2017.zip -d /tmp/coco
unzip -q annotations_trainval2017.zip -d /tmp/coco

echo "Preparing dataset..."
pushd ${MLPERF_INF_ROOT}/v0.5/tools/upscale_coco
python3 upscale_coco.py --inputs /tmp/coco --outputs ${DATA_DIR} --size 300 300 --format jpg
popd

echo "Cleaning up..."
rm -r val2017.zip
rm -r annotations_trainval2017.zip
rm -r /tmp/coco
