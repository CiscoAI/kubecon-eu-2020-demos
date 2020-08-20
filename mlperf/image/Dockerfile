FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    curl \
    htop \
    tar \
    unzip \
    python3 \
    python3-pip \
    python3-dev \
    software-properties-common \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-glx \
    libglib2.0-0

RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir setuptools && \
    pip3 install --no-cache-dir Cython
RUN pip3 install --no-cache-dir \
    requests \
    tensorflow==1.15.0 \
    tensorflow-serving-api==1.15.0 \
    pillow \
    opencv-python \
    pycocotools

WORKDIR /mlperf

RUN git clone --recurse-submodules --depth 1 --branch kubecon-eu-2020 \
    https://github.com/CiscoAI/mlperf-inference.git inference && \
    cd inference && \
    cd loadgen && \
    pip3 install pybind11 && \
    CFLAGS="-std=c++14" python3 setup.py install

COPY scripts/env.sh scripts/get_data.sh scripts/get_model.sh /mlperf/scripts/
RUN cd /mlperf/scripts && bash get_model.sh
RUN cd /mlperf/scripts && bash get_data.sh
COPY scripts/run.sh scripts/run_common.sh scripts/run_helper.sh /mlperf/scripts/
COPY configs /mlperf/configs
COPY licenses /mlperf/

ENTRYPOINT ["/bin/bash"]
