# Labs 003

**Nội dung**: Làm quen sử dụng [Terraform](https://www.terraform.io/) để deploy Kubernetes Manifest Files vào Minikube Cluster

**NOTE:**

- Labs 003 này sẽ sử dụng **[Local Backend](https://www.terraform.io/language/settings/backends/local)** để lưu trữ Terraform State và chỉ nên sử dụng trên môi trường Development

## 1. Chuẩn bị

Yêu cầu đã đọc qua và hoàn tất

- **[Getting Started](../../docs/getting_started.md)**: Khởi tạo Minikube Cluster
- **[Labs 001](../001-laravel-app-minikube/)**: Hiểu về Kubernetes Manifest Files và Sample Laravel Application

## 2. Thực hành

**Step 1:** Cài đặt Terraform Binary sử dụng script **[install-terraform.sh](../../tools/install-terraform.sh)**

```
$ ./tools/install-terraform.sh
```

NOTE: Có thể cài đặt thông qua **[tfenv](https://github.com/tfutils/tfenv)**, hoặc sử dụng **[Docker Image](https://hub.docker.com/r/hashicorp/terraform/)**

**Step 2:** Copy Kubernetes Manifest Files từ **[Labs-001](../001-laravel-app-minikube/)** sử dụng command **[cp](https://man7.org/linux/man-pages/man1/cp.1.html)**

```
cp -R ../001-laravel-app-minikube/manifests .
```

**Step 3:** Viết code Terraform

**Step 4:** Kiểm tra Terraform Plan

**Step 5:** Apply Terraform Plan

## 3. Kiểm tra

Cách kiểm tra tương tự như **[Labs 001](../001-laravel-app-minikube/)**

## 4. Clean up

Sự dụng command sau để xóa tất cả thay đổi trên Minikube Cluster

```
$ terraform destroy
```
