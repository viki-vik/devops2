## Run Flask Application on EKS Cluster
##### This repository contains the necessary files and configurations to deploy a Flask application on an EKS cluster using Docker, Kubernetes, Helm, and Terraform.

#### Step 1: Install Dependencies
Ensure you have Python 3.9 installed. Install the necessary dependencies:

```
pip install -r requirements.txt
```
#### Step 2: Run Flask Application
Run the Flask application:
```
export FLASK_APP=app/app.py
flask run
```
The application will be accessible at [http://127.0.0.1:5000].

### Building and Running Docker Container
#### Step 1: Build Docker Image
To build the Docker image for the Flask app, run:
```
docker build -t flask-app:latest .
```
#### Step 2: Run Docker Container
To run the Docker container on port 80:
```
docker run -d -p 80:5000 --name flask-app flask-app:latest
```
The application will be accessible at [http://localhost].

### Deploying with Kubernetes
#### Step 1: Create EKS Cluster
If you haven't already created an EKS cluster, use the following command after configuring aws profile and credentials:
```
eksctl create cluster -f kubernetes/eks-clusterconfig.yaml
```
#### Step 2: Deploy the Flask Application
Deploy the Flask app using kubectl:
```
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml
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
### Infrastructure Setup with Terraform
#### Step 1: Initialize Terraform
Navigate to the terraform/ directory and initialize Terraform:
```
cd terraform/
terraform init
```
#### Step 2: Apply Terraform Configuration
To provision the necessary AWS infrastructure (VPC, EKS cluster, Route53), run:
```
terraform apply
```
#### Step 3: Destroy Terraform Infrastructure (Optional)
To destroy the infrastructure, run:
```
terraform destroy
```
