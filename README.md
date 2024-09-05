## Run Flask Application on EKS Cluster
##### This repository contains the necessary files and configurations to deploy a Flask application on an EKS cluster using Docker, Kubernetes, Helm, and Terraform.

### Infrastructure Setup with Terraform
#### Step 1: Initialize Terraform
Navigate to the terraform/ directory and initialize Terraform:
```
cd terraform/
terraform init
```
#### Step 2: Apply Terraform Configuration
To provision the necessary AWS infrastructure (VPC, EKS cluster, Route53), run after configuring aws profile and credentials:
```
terraform apply
```

### Building and Running Docker Container
#### Step 1: Build Docker Image
To build the Docker image for the Flask app. Navigate to `flask-app` directory and run:
```
cd flask-app
docker build -t flask-app:latest .
```
#### Step 2: Run Docker Container
To run the Docker container on port 80:
```
docker run -d -p 80:5000 --name flask-app flask-app:latest
```
The application will be accessible at [ http://localhost ].

### Deploying with Kubernetes
If the EKS cluster is already deployed with terraform destroy it by running this command:
```
terraform destroy
```
#### Step 1: Create EKS Cluster
Use the following command to deploy EKS cluster with kubernetes manifest:
```
eksctl create cluster -f k8s/eks-clusterconfig.yaml
```
#### Step 2: Deploy the Flask Application
Run the application on any kind of Kubernetes distribution: k3d, rancher, minikube, or else.
Deploy the Flask app using kubectl:
```
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
```
#### Step 3: Verify Deployment
Check the status of your deployment:
```
kubectl get pods
kubectl get services
```
### Helm Chart Deployment
#### Step 1: Initialize Helm
Ensure Helm is initialized and your Kubernetes cluster is configured.

#### Step 2: Install the Flask Application via Helm
Navigate to the helm/ directory and deploy the Helm chart:
```
helm install flask-app ./helm
```
#### Step 3: Verify Helm Deployment
Check the status of the Helm release:
```
helm status flask-app
```

