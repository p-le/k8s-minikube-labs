# Labs 001

**Nội Dung**: Sử dụng Laravel Docker Image và Deploy vào Minikube Cluster

Ở labs 001 này, chúng ta sẽ sử dụng Kubernetes Manifest Files đơn thuần để quản lý Resources trong Kubernetes Cluster.

**[Manifest Files](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/)** thường được viết dưới format YAML. Trong Labs này mình đã chuẩn Manifest Files để deploy [Laravel](https://laravel.com/) + [MySQL](https://www.mysql.com/) vào Minikube Cluster.

Về Docker Image, để đơn giản hóa, mình sử dụng 2 Docker Image có sẵn là

- **[bitnami/laravel](https://hub.docker.com/r/bitnami/laravel)**
- **[bitnami/mysql](https://hub.docker.com/r/bitnami/mysql)**

## 1. Chuẩn bị

Yêu cầu đã đọc qua và hoàn tất

**[Getting Started](../../docs/getting_started.md)**: Khởi tạo Minikube Cluster

## 2. Thực hành

**Step 1:** Thử chạy Laravel + MySQL với **[docker-compose](https://docs.docker.com/compose/)**

Mình đã chuẩn bị file **[docker-compose.yaml](./docker-compose.yaml)** các bạn có thể chạy luôn với command sau:

```
$ cd labs/001-laravel-app-minikube
$ docker-compose up
```

Sau khi chạy thì **[docker-compose.yaml](./docker-compose.yaml)** sẽ lần lượt chạy các container: **app** và **db**.

```
app    | laravel 11:49:36.10 INFO  ==> ** Starting Laravel project **
app    | Starting Laravel development server: http://0.0.0.0:8000
app    | [Mon Apr  4 11:49:36 2022] PHP 8.1.4 Development Server (http://0.0.0.0:8000) started
```

Sau khi Console Logs ra output như này, các bạn hay thử access vào **http://localhost:8000**.

**NOTE:** Nếu chạy trong Vagrant thì các bạn cần phải thay `localhost` bằng `IP của Vagrant VM`: **http://VAGRANT-VM-IP:8000** hoặc **[Setup Port Forwarding](https://www.vagrantup.com/docs/networking/forwarded_ports)**

**Step 2:** Deploy Kubernetes Manifest Files sử dụng **[kubectl](https://kubernetes.io/docs/tasks/tools/)**

Sau khi đã thử chạy trên môi trường Development, tiếp theo là deploy vào Minikube Cluster.

Mình đã chuẩn bị các Manifest Files trong folder: **[manifests](./manifests/)**

```
├── laravel-deployment.yaml
├── laravel-service.yaml
├── mysql-configmap.yaml
├── mysql-service.yaml
└── mysql-statefulset.yaml
```

**Overview:**

- Đối với Laravel Container: sử dụng **[Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)** để deploy. Và sau đó mình tạo một **[NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)** service để sau này access tới Laravel
- Đối với MySQL Container: sử dụng **[StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)** để deploy. Đồng thời mình cũng setup Master/Slave đơn giản với MySQL sử dụng các Environment variables mà **[bitnami/mysql](https://hub.docker.com/r/bitnami/mysql)** hỗ trợ: `MYSQL_REPLICATION_MODE`, `MYSQL_REPLICATION_USER` `MYSQL_REPLICATION_PASSWORD`. Sau đó mình tạo một **[Headless Service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)** để thiết lập Service Discovery qua DNS tới **[StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)** MySQL

Để deploy manifests, các bạn có thể thực thi script: **[deploy.sh](./deploy.sh)**

Thực chất trong script này, bao gồm các command `kubectl apply -f`

```
$ ./deploy.sh
```

## 3. Kiểm tra

| OS          | Thao tác                                                                                                                                                                                                                                           |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Linux/MacOS | Chạy command: `minikube service --url laravel` và access tới URL của Service `laravel`                                                                                                                                                             |
| Windows     | Nếu bạn sử dụng Vagrant thì cần phải chạy Kubectl Proxy Command: `kubectl proxy --address='0.0.0.0' --disable-filter=true`. <br /> Sau đó thì access tới URL sau: `http://<VAGRANT-VM-IP>:8001/api/v1/namespaces/default/services/laravel:/proxy/` |

## 4. Clean up

Sử dụng **[kubectl](https://kubernetes.io/docs/tasks/tools/)** để xóa các Objects đã tạo trong Minikube Cluster: **[destroy.sh](./destroy.sh)**

```
$ ./destroy.sh
```
