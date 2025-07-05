# Laravel Kubernetes Project

This project demonstrates how to deploy a Laravel application on Kubernetes using:
- NGINX (custom Docker image)
- PHP-FPM
- MySQL
- CI/CD pipeline (Jenkinsfile)


Build the image
----------------
docker build -t laravel-app .
docker build -t nginx-laravel -f nginx/Dockerfile .



2. Build Docker Images
docker build -t php-laravel ./app
docker build -t php-laravel .           # i use this becaue the Dockerfile is is in root
docker build -t nginx-laravel ./nginx
or
docker build -t nginx-laravel -f nginx/Dockerfile .

2A. Tag and Push the image
docker tag php-laravel devopssteps/php-laravel:latest
docker push devopssteps/php-laravel:latest

3. Deploy to Kubernetes
kubectl apply -f k8s/deployment.yaml

4. Access App
If using Minikube:
minikube service nginx

Visit the exposed URL (e.g., http://127.0.0.1:30080)

📦 What's Included
app/ → Laravel PHP-FPM Dockerfile (you should place Laravel app here)
nginx/ → Custom NGINX config & Dockerfile
k8s/ → Kubernetes YAML (PHP, NGINX deployments & services)
ci/Jenkinsfile → CI/CD pipeline for Jenkins

Let me know when you want to extend this further with:
Real Laravel code and migrations
MySQL setup and secrets in Kubernetes
GitHub Actions pipeline
HTTPS ingress (Traefik/Nginx Ingress)# depops-project-5-laravel-deploy-k8s
# laravel-k8s-cicd-minikube-deploy-without-ansible
