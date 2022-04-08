# 1. Cài đặt [Minikube](https://minikube.sigs.k8s.io/docs/)

**[Lựa chọn Binary](https://minikube.sigs.k8s.io/docs/start/)** phù hợp với môi trường của các bạn.

**Note 1**: Nếu đang sử dụng **Windows** thì các bạn có thể xem xét provision một Ubuntu VM bằng **[Vagrant](https://www.vagrantup.com)** & **[VirtualBox](https://www.virtualbox.org)**. Sau đó setup **[VS Code Remote Development](https://code.visualstudio.com/docs/remote/ssh)** thông qua SSH để develop trong Virtual Machine tạo bằng Vagrant.

Đây là cách mình hiện tại sử dụng. Bởi vì develop trên môi trường Linux sẽ thuận tiện hơn rất nhiều. Mặc định thì mình sử dụng Linux Distribution là Ubuntu.

Tham khảo: **[Vagrantfile](../tools/Vagrantfile)** mà mình đã chuẩn bị

Nếu các bạn sử dụng Linux có thể chạy script **[install-minikube.sh](../tools/install-minikube.sh)** mình đã chuẩn bị.

```shell
$ ./tools/install-minikube.sh
```

**Note 2:** Các bạn cũng có thể **[sử dụng WSL](https://docs.microsoft.com/en-us/windows/wsl/install)** trên hệ điều hành Windows để cài đặt hệ điều hành Linux.

# 2. Khởi tạo Minikube Cluster

**[Môi trường chạy Minikube](https://minikube.sigs.k8s.io/docs/start/#what-youll-need)** cần phải có ít nhất.

- 2 CPU
- 2 GB Free Memory
- 20 GB Free Disk Space

Khởi tạo Minikube Cluster bằng command sau:

```
$ minikube start
```

Output minh họa:

```
😄  minikube v1.25.2 on Ubuntu 18.04 (vbox/amd64)
✨  Automatically selected the docker driver. Other choices: none, ssh
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
💾  Downloading Kubernetes v1.23.3 preload ...
    > preloaded-images-k8s-v17-v1...: 505.68 MiB / 505.68 MiB  100.00% 10.11 Mi
🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
🐳  Preparing Kubernetes v1.23.3 on Docker 20.10.12 ...
    ▪ kubelet.housekeeping-interval=5m
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...|\
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

# 3. Truy cập thử Dashboard của Minikube

Sử dụng command sau để lấy URL tới Dashboard.

```
$ minikube dashboard
```

Command trên sẽ tạo một Proxy tới **kubernetes-dashboard** service

```
🔌  Enabling dashboard ...
    ▪ Using image kubernetesui/dashboard:v2.1.0
    ▪ Using image kubernetesui/metrics-scraper:v1.0.4
🤔  Verifying dashboard health ...
🚀  Launching proxy ...
🤔  Verifying proxy health ...
🎉  Opening http://127.0.0.1:45229/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...


```

# 4. Cài đặt [kubectl](https://kubernetes.io/docs/tasks/tools/) và kiểm tra Minikube Cluster

Sử dụng script: **[install-kubectl.sh](../tools/install-kubectl.sh)**

```
$ ./tools/install-kubectl.sh
```

Kiểm tra **[kubectl](https://kubernetes.io/docs/tasks/tools/)** đã cài đặt thành công

```

$ kubectl version --short

Client Version: v1.23.5
Server Version: v1.23.3
```

Thử kiểm tra các **[Pods](https://kubernetes.io/docs/concepts/workloads/pods/)** trong **[Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)**: `kube-system`

NOTE: `kube-system` là namespace chứa các objects tạo Kubernetes System

```
$ kubectl get pods -n kube-system
```

Sample Output:

```

NAME READY STATUS RESTARTS AGE
coredns-64897985d-gfqfl 1/1 Running 0 2m31s
etcd-minikube 1/1 Running 0 2m46s
kube-apiserver-minikube 1/1 Running 0 2m41s
kube-controller-manager-minikube 1/1 Running 0 2m41s
kube-proxy-9kdrg 1/1 Running 0 2m31s
kube-scheduler-minikube 1/1 Running 0 2m41s
storage-provisioner 1/1 Running 1 (116s ago) 2m35s

```

Đến đây coi như là các bạn đã hoàn tất setup cơ bản để sử dụng Minikube trên môi trường Development. :tada:
