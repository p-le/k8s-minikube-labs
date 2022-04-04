# Labs 003

**Nội dung**: Làm quen sử dụng **[Terraform](https://www.terraform.io/)** để deploy Kubernetes Resource vào Minikube Cluster

**NOTE:**

- Trong Labs 003 này, mình sẽ sử dụng **[Local Backend](https://www.terraform.io/language/settings/backends/local)** để lưu trữ Terraform State và các bạn chỉ nên sử dụng **[Local Backend](https://www.terraform.io/language/settings/backends/local)** trên môi trường Development.

## 1. Chuẩn bị

Yêu cầu: Các bạn đã đọc qua và hoàn tất

- **[Getting Started](../../docs/getting_started.md)**: Khởi tạo Minikube Cluster, cài đặt **[kubectl](https://kubernetes.io/docs/tasks/tools/)**
- **[Labs 001](../001-laravel-app-minikube/)**: Hiểu về Kubernetes Manifest Files và Sample Laravel Application

## 2. Thực hành

**Step 1:** Cài đặt Terraform Binary sử dụng script **[install-terraform.sh](../../tools/install-terraform.sh)** mà mình đã chuẩn bị. Sau đó có thể kiểm tra nhanh bằng command: `terraform version`

```
$ ./tools/install-terraform.sh
$ terraform version

Terraform v1.0.1
on linux_amd64
```

**NOTE**: Các bạn cũng có thể cài đặt thông qua **[tfenv](https://github.com/tfutils/tfenv)**, hoặc sử dụng **[Docker Image](https://hub.docker.com/r/hashicorp/terraform/)**

**Step 2:** Copy Kubernetes Manifest Files từ **[Labs-001](../001-laravel-app-minikube/)** sử dụng command **[cp](https://man7.org/linux/man-pages/man1/cp.1.html)**

```
$ cp -R ../001-laravel-app-minikube/manifests .
```

```
├── laravel-deployment.yaml
├── laravel-service.yaml
├── mysql-configmap.yaml
├── mysql-service.yaml
└── mysql-statefulset.yaml
```

**Step 3:** Viết code Terraform
Ở đây mình sẽ sử dụng 2 terraform Provider:

- **[Kubernetes Provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)**: quản lý Kubernetes Cluster
- **[kubectl Provider](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs)**: quản lý Kubernetes Resources bằng YAML

Đâu tiên, các bạn cần:

- Tạo file **[provider.tf](./provider.tf)**: dùng để lưu trữ thông tin cũng như version của các **[Provider](https://www.terraform.io/language/providers)** sử dụng trong Terraform Code
- Đối với **[Kubernetes Provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)** và **[kubectl Provider](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs)**: để access tới Minikube cluster trên môi trường Development, mình sẽ dùng 2 thông tin là: `config_path`, `config_context` như sau:

```
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}
```

`~/.kube/config`: Là File config mặc định được tạo ra dưới Home Directory của User trong Linux. Khi tạo Minikube Cluster sẽ tự động sinh ra 1 context có tên là `minikube`

Sau khi đã có **[provider.tf](./provider.tf)**. Tiếp theo, các bạn chạy command: `terraform init` để tải các Provider về môi trường Development.

```
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding gavinbunney/kubectl versions matching "1.14.0"...
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Installing gavinbunney/kubectl v1.14.0...
- Installed gavinbunney/kubectl v1.14.0 (self-signed, key ID AD64217B5ADD572F)
- Using previously-installed hashicorp/kubernetes v2.9.0

<skipped>
```

Tiếp theo, tao file: **[k8s.tf](./k8s.tf)** để tạo các Terraform Resource cần thiết để deploy Manifest file trong **[Labs 001](../001-laravel-app-minikube/)**

- Dùng function **[fileset](https://www.terraform.io/language/functions/fileset)** để liệt kê các Manifest Files trong thư mục manifests
- Sau đó sử dụng Resource **[kubectl_manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/kubectl_manifest)** để deploy các Manifest File vào Minikube Cluster. Đồng thời sử dụng chức năng **[for_each](https://www.terraform.io/language/meta-arguments/for_each)** của Terraform để loop tất cả các Manifest Files.

**Step 4:** Kiểm tra Terraform Plan

**Step 5:** Apply Terraform Plan

## 3. Kiểm tra

Cách kiểm tra tương tự như **[Labs 001](../001-laravel-app-minikube/)**

## 4. Clean up

Sự dụng command sau để xóa tất cả thay đổi trên Minikube Cluster

```
$ terraform destroy
```
