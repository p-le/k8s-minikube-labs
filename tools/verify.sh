#!/bin/bash

echo "-- Docker Version"
docker version --format '{{.Server.Version}}'

echo "-- Minikube Version"
minikube version

echo "-- Kubectl Version"
kubectl version --short

echo "-- Helm Version"
helm version

echo "-- Skaffold Version"
skaffold version

echo "-- Terraform Version"
terraform version