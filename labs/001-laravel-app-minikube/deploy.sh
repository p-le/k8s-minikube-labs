#!/bin/bash
set -x

kubectl apply -f manifests/mysql-configmap.yaml
kubectl apply -f manifests/mysql-statefulset.yaml
kubectl apply -f manifests/mysql-service.yaml
kubectl apply -f manifests/laravel-deployment.yaml
kubectl apply -f manifests/laravel-service.yaml