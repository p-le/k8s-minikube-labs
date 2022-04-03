# Labs 001

**Vấn đề**: Deploy Laravel App vào Minikube Cluster

## 1. Chuẩn bị

Hoàn tất `docs/getting_started.md` để khởi tạo Minikube Cluster

## 2. Thực hành

- Deploy Kubernetes Manifest Files

```
cd labs/001-laravel-app-minikube
./deploy.sh
```

## 3. Kiểm tra

- Nếu là Linux/MacOS

```
minikube service --url laravel
```

Access vào URL được trả về từ command trên

- Nếu là Windows & Vagrant

```
kubectl proxy --address='0.0.0.0' --disable-filter=true
```

Access vào: http://<VAGRANT-VM-IP>:8001/api/v1/namespaces/default/services/laravel:/proxy/

## 4. Clean up

```
./destroy.sh
```
