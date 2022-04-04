# Lab 002

**Nội Dung**: Đóng gói Helm Chart và sau đó deploy vào Minikube Cluster

**[Helm](https://helm.sh/)** là công cụ giúp quản lý Manifest Files của các Application dược deploy vào Kubernetes. Sau khi đóng gói chúng ta có Helm Chart, tương tự với Package trong NodeJS, Python. Helm Chart có thể chia sẻ, cũng như versioning, publish như một package bình thường.

**[Helm](https://helm.sh/)** sẽ cung cấp các chức năng templating, giúp các bạn tùy chỉnh nội dung của Kubernetes Manifest Files một cách dễ dàng hơn rất nhiều.

## 1. Chuẩn bị

Yêu cầu: Các bạn đã đọc qua và hoàn tất

- **[Getting Started](../../docs/getting_started.md)**: Khởi tạo Minikube Cluster, cài đặt **[kubectl](https://kubernetes.io/docs/tasks/tools/)**
- **[Labs 001](../001-laravel-app-minikube/)**: Hiểu về Kubernetes Manifest Files và Sample Laravel Application

## 2. Thực hành

Khởi tạo Base Chart có tên là `laravel-app`

```
Format: helm create <chart-name>

$ cd labs/002-laravel-app-minikube-helm-chart
$ helm create laravel-app
```

Xóa tất cả files trong `laravel-app/templates` vì không cần thiết.

```
$ rm -rf laravel-app/templates/*
```

Copy Kubernetes Manifest Files từ **[Labs-001](../001-laravel-app-minikube/)** sử dụng command **[cp](https://man7.org/linux/man-pages/man1/cp.1.html)**

Về cơ bản chỉ cần copy tất cả các Manifests ở Labs 001 là có thể tạo thành Helm Chart.

```
$ cp -R ../001-laravel-app-minikube/manifests/* laravel-app/templates/
```

Ở mỗi thuôc tính metadata.name. Thêm `{{ .Release.Name }}-` để gắn thêm prefix vào resource name sử dụng chức năng Templating của Helm

Ví dụ:

```
metadata:
  name: {{ .Release.Name }}-laravel-app
```

Cài đặt thử Helm Chart vào Minikube Cluster để kiểm tra

**NOTE**: Trong thực tế, các bạn sẽ cần phải chạy command `helm package` để tạo file archive của Helm Chart. Sau đấy publish lên **[Helm Chart Repository](https://helm.sh/docs/topics/chart_repository/)**.

```
Format: helm install <release-name> <chart-dir>

$ helm install lab-002 ./laravel-app
```

## 3. Kiểm tra

Cách kiểm tra tương tự như **[Labs 001](../001-laravel-app-minikube/)**

Điểm khác với Lab 001 là: tên của Pods và Services sẽ có thêm prefix là `lab-002`

```
$ kubectl get svc

NAME              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
kubernetes        ClusterIP   10.96.0.1        <none>        443/TCP          46h
lab-002-laravel   NodePort    10.104.236.249   <none>        8000:30617/TCP   11s
lab-002-mysql     ClusterIP   None             <none>        3306/TCP         11s
```

## 4. Clean up

```
Format: helm uninstall <release-name>

$ helm uninstall lab-002
```

# Tổng kết

Trong Labs này các bạn sẽ cần phải tìm hiểu về Helm. Các bạn có thể thử dùng một số chức năng templating đơn giả của Helm như Variables.
