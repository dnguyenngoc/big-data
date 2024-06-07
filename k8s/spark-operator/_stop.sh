#!/bin/bash
kubectl delete -f statefulset.yaml
kubectl delete -f ./crds/
kubectl delete -f rbac.yaml
kubectl delete -f configmap.yaml
kubectl delete -f namespace.yaml
