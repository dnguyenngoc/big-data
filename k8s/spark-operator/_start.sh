#!/bin/bash
kubectl apply -f namespace.yaml
kubectl apply -f configmap.yaml
kubectl apply -f rbac.yaml
kubectl apply -f ./crds/
kubectl apply -f statefulset.yaml
