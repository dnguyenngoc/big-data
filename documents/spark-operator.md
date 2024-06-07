# Spark Operator

Spark Operator is a Kubernetes Operator designed for Spark. It aims to define and execute Spark applications as easily as other workloads on Kubernetes by using and managing Kubernetes custom resources (CRDs) to specify, run, and update the status of Spark applications.

To learn more, you can check out the [Design](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/design.md), [API Specification](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/user-guide.md), and [User Guide](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/user-guide.md) on GitHub.

![Spark Operator](./images/spark-operator.png)

## Why Choose Spark Operator

The Spark Operator simplifies the deployment and management of Spark applications on Kubernetes. It provides a declarative way to run Spark applications, handling the complexities of resource management, scheduling, and monitoring. This allows developers to focus on writing Spark code rather than managing the underlying infrastructure. Additionally, Spark Operator supports both batch and streaming workloads, making it versatile for various big data processing needs.

A Spark application can be defined declaratively in a YAML file, which allows for easy management and execution using Kubernetes tools such as kubectl.

### How it Works

- Define the Spark Application in YAML: You create a YAML file that describes your Spark application. This file includes specifications such as the type of application (e.g., Python, Java), the Docker image to use, resource requirements for drivers and executors, and other configuration settings.

- Apply the YAML File Using kubectl: Once the YAML file is ready, you can use kubectl to apply this file to your Kubernetes cluster. The Spark Operator will then read this file, create the necessary Kubernetes resources, and manage the lifecycle of the Spark application.

## 1. Spark Operator with Kubernetes
```sh
git clone https://github.com/dnguyenngoc/big-data.git
cd big-data/k8s
sh _start.sh spark-operator
kubectl get pod,statefulset -n spark-operator
```

## 2. Submit Application
A SparkApplication is essentially a CRD resource that can be applied to the cluster using kubectl, as shown in the example below:
```yaml
---
apiVersion: 'sparkoperator.k8s.io/v1beta2'
kind: SparkApplication
metadata:
  name: pyspark-pi
  namespace: spark-operator
spec:
  type: Python
  pythonVersion: '3'
  mode: cluster
  image: 'duynguyenngoc/spark:3.5.1'
  imagePullPolicy: Always
  mainApplicationFile: local:///opt/spark/examples/src/main/python/pi.py
  sparkVersion: '3.5.1'
  restartPolicy:
    type: OnFailure
    onFailureRetries: 3
    onFailureRetryInterval: 10
    onSubmissionFailureRetries: 5
    onSubmissionFailureRetryInterval: 20
  driver:
    cores: 1
    coreLimit: '1200m'
    memory: '512m'
    labels:
      version: 3.5.1
    serviceAccount: sparkoperator
  executor:
    cores: 1
    instances: 1
    memory: '512m'
    labels:
      version: 3.5.1
```

To submit this Spark Pi application to Kubernetes, simply use:

```sh
kubectl apply -f spark-pi.yaml
kubectl get sparkapp -n spark-operator
```