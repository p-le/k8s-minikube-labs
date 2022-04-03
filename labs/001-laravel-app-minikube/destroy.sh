#!/bin/bash
set -x

kubectl delete -f manifests/mysql-configmap.yaml
kubectl delete -f manifests/mysql-statefulset.yaml
kubectl delete -f manifests/mysql-service.yaml
kubectl delete -f manifests/laravel-deployment.yaml
kubectl delete -f manifests/laravel-service.yaml