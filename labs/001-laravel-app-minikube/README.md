# Labs 001

**Vấn đề**: Deploy Laravel App vào Minikube Cluster

## 1. Chuẩn bị

Hoàn tất `docs/getting_started.md` để khởi tạo Minikube Cluster

## 2. Thực hành

> To deploy local docker images (without pushed to registry or repo), you have to send the images to minikube.
> Find out more details [here](https://stackoverflow.com/questions/49898535/kubernetes-fails-to-run-a-docker-image-build-locally) and [here](https://blog.hasura.io/sharing-a-local-registry-for-minikube-37c7240d0615).
>
> ```
> docker save YOUR_IMAGE_NAME:YOUR_IMAGE_TAG | (eval $(minikube docker-env) && docker load)
> ```

1. Configure your containers using [ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/).

   ```
   // Nginx configuration
   kubectl apply -f k8s/configurations/configmap-nginx.yaml

   // Laravel environment
   // Files for different environments are located in ./docker/app directory
   kubectl apply configmap configmap-laravel-env \
       --from-env-file=./docker/app/laravel.dev.env
   ```

2. Deploy kurbenetes workloads and services like [Pods](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/) and [Services](https://kubernetes.io/docs/concepts/services-networking/service/) from manifest files.

   ```
   // Set environment variables in your shell and run the following command
   cat k8s/deployments/deployment.yaml | \
   sed 's/\${PROJECT_ID}'"/$PROJECT_ID/g" | \
   sed 's/\${COMMIT_SHA}'"/$COMMIT_SHA/g" | \
   kubectl apply -f -
   // OR
   // Edit your images name in ./k8s/deployments/deployment.yaml and run the following command
   kubectl apply -f k8s/deployments/deployment.yaml

   // k8s service
   kubectl apply -f k8s/services/service.yaml
   ```

3. Access k8s services via
   ```
   // minikube service SERVICE-NAME
   minikube service service-my-laravel-app
   ```
