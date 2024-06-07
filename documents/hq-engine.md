# High-Performance Query Engine with Trino

Trino is a high-performance, distributed SQL query engine designed for big data analytics. It is capable of querying large datasets across various data sources, providing fast and interactive querying capabilities.

To learn more, you can check out the [Introduction](https://trino.io/docs/current/overview/intro.html), [Concepts](https://trino.io/docs/current/overview/concepts.html), and [User Guide](https://trino.io/docs/current/installation/cli.html) on the Trino documentation site.

## Why Choose Trino

Trino is designed for interactive analytics and provides excellent performance for querying large datasets. Its ability to federate queries across multiple data sources, including HDFS, S3, MySQL, and others, makes it a versatile tool for data engineers and analysts. Trino's support for ANSI SQL, complex queries, and real-time analytics ensures that it can handle a wide range of analytical workloads efficiently.

## 1. Trino with Kubernetes
```sh
git clone https://github.com/dnguyenngoc/big-data.git
cd big-data/k8s
sh _start.sh hive-metastore trino-operator 
kubectl get pod,statefulset -n hq-engine
```
(In Developing)