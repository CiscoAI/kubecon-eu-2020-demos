# MLPerf Inference on Kubernetes Demo

This demo provides a simple example of running MLPerf inference benchmark on Kubernetes. The example demonstrates performance tests with a Tensorflow SSD-Mobilenet model on the following setups:

* Tensorflow backend on a single pod

  (The local TF backend is available in MLPerf Inference's [reference implementation](https://github.com/mlperf/inference).)

* TF Serving backend with a client pod and a TF Serving service

  (The TF Serving backend is implemented [here](https://github.com/CiscoAI/mlperf-inference/tree/kubecon-eu-2020). Note that the implementation is limited to this demo purpose only and does not imply compliance with the official MLPerf design and rules.)


## Quick Start

### Preparation

Create config and output paths on the Kubernetes host. The demo assumes a single-host cluster and will mount a default HostPath volume to the benchmark pods. You may change this by modifying the [manifests](./manifests).

```sh
mkdir -p /tmp/mlperf/configs /tmp/mlperf/outputs
cp image/configs/mlperf.conf /tmp/mlperf/configs/
```

Change work directory for the next steps.

```sh
cd manifests
```

### Run a benchmark test with local TF backend

```sh
kubectl create -f tf-benchmark.yaml
```

If you followed the preparation step above, you should find benchmark outputs under `/tmp/mlperf/outputs`.

### Run a benchmark test with TF Serving backend

1. Deploy TF Serving model service
  ```sh
  kubectl create -f tfserving-service.yaml
  ```

2. Deploy benchmark job
  ```sh
  sed -e "s/{{MODEL_SVC_IP}}/$(kubectl get svc ssd-mobilenet-service -o=jsonpath={.spec.clusterIP})/g" tfserving-benchmark.tmpl.yaml > tfserving-benchmark.yaml
  kubectl create -f tfserving-benchmark.yaml
  ```

If you followed the preparation step above, you should find benchmark outputs under `/tmp/mlperf/outputs`.

## Customizations

### Change benchmark parameters

You may modify the [mlperf.conf](./image/configs/mlperf.conf) file to change certain benchmark parameters. If you followed the preparation step above, the config file is located at `/tmp/mlperf/configs/mlperf.config` on your Kuberntes host and will be mounted by default. Otherwise, make sure the file is mounted under `/mlperf/configs` in your pods.

### Change run scripts and arguments

To add or change arguments to the run script, which control certain benchmark options, you can modify the [manifests](./manifests). If you modify the run [scripts](./image/scripts), make sure the files are mounted under `/mlperf/scripts` in your pods.
