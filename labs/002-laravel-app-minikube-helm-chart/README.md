# Labs 001

**Vấn đề**: Đóng gói Helm Chart và sau đó deploy vào Minikube Cluster

[Helm](https://helm.sh/) là công cụ giúp quản lý các Application dược deploy vào Kubernetes. Helm Chart tương tự như Package trong NodeJS, Python. sẽ bao gồm các Kubernetes Manifest Files và có thể chia sẻ, cũng như versioning, publish như một package bình thường.

## 1. Chuẩn bị

Hoàn tất `docs/getting_started.md` để khởi tạo Minikube Cluster

## 2. Thực hành

- Khởi tạo Base Chart

```
Format: helm create <chart-name>

helm create laravel-app
```

- Xóa tất cả files trong `laravel-app/templates`

```
rm -rf laravel-app/templates/*
```

- Copy Manifest Files từ labs-001
  Về cơ bản chỉ cần copy tất cả các Manifests ở Labs 001 là có thể tạo thành Helm Chart

```
./copy-manifests.sh
```

- Install Helm Chart Locally

```
Format: helm install <release-name> <chart-dir>

$ helm install 002-labs ./laravel-app
```

## 3. Kiểm tra

Cách kiểm tra tương tự như labs đầu tiên

## 4. Clean up

```
Format: helm uninstall <release-name>

helm uninstall 002-labs
```
