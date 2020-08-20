#!/bin/bash

source env.sh

mkdir -p ${MODEL_DIR}

echo "Downloading model..."
wget -q http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v1_coco_2018_01_28.tar.gz

echo "Extracting model..."
tar xzf ssd_mobilenet_v1_coco_2018_01_28.tar.gz
cp ssd_mobilenet_v1_coco_2018_01_28/frozen_inference_graph.pb ${MODEL_DIR}/ssd_mobilenet_v1_coco_2018_01_28.pb
cp -r ssd_mobilenet_v1_coco_2018_01_28/saved_model ${MODEL_DIR}/1

echo "Cleaning up..."
rm -r ssd_mobilenet_v1_coco_2018_01_28*
