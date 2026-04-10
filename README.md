#  Building & Deploying a Node.js Microservice on AWS (ECS Fargate) with Terraform & CI/CD

This project showcases a production-grade DevOps workflow where I designed, built, containerized, automated, and deployed a Node.js microservice on AWS using modern cloud and DevOps practices.

## Project Overview

I built a Node.js-based user microservice and containerized it using Docker to ensure consistency across environments and simplify deployment.

To automate the software delivery process, I implemented a CI/CD pipeline using GitHub Actions. This pipeline builds and pushes Docker images to Docker Hub on every commit, enabling continuous integration and faster delivery.

Using Terraform, I provisioned the required AWS infrastructure, including a VPC, ECS Fargate cluster, security groups, and an Application Load Balancer (ALB). This setup ensures scalability, high availability, and proper traffic routing.

The application was deployed on ECS Fargate (serverless containers), eliminating the need for server management while maintaining reliability and scalability. Incoming traffic is routed through the ALB to the ECS service, making the application publicly accessible.

This project reflects my ability to design and implement end-to-end DevOps solutions, combining infrastructure automation, containerization, and cloud deployment in a real-world scenario.


## Architecture

Client (Browser)

↓

Application Load Balancer (ALB)

↓

Target Group

↓

ECS Service (Fargate)

↓

Task Definition

↓

Docker Container (Node.js App from Docker Hub)

## App Architecture Diagram

![App Architecture Diagram](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/CI_CD%20pipeline%20architecture%20diagram.png)

## Technologies Used

* Node.js (Express)
* Docker
* Docker Hub
* Terraform
* GitHub Actions (CI/CD)
* AWS ECS (Fargate)
* AWS Application Load Balancer (ALB)
* Git & GitHub

## Project Structure

user-microservice/
├── app/

│   ├── app.js

│   ├── package.json

│   └── Dockerfile

├── .github/

│   └── workflows/

│       └── cicd.yml

├── terraform/

│   ├── main.tf

│   ├── variables.tf

│   ├── outputs.tf

│   └── terraform.tfvars

└── screenshots/


##  Step-by-Step Reproduction Guide

### Step 1: Create Project Structure

```bash
mkdir user-microservice
cd user-microservice

mkdir app terraform .github/workflows 
```

### Step 2: Build Node.js App

```bash
cd app
npm init -y
npm install express
```

Create `app.js`:

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('User Microservice Running ');
});

app.get('/api/users', (req, res) => {
  res.json([
    { id: 1, name: "Chidera" },
    { id: 2, name: "Pam" }
  ]);
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

Run locally:

```bash
node app.js
```

### Step 3: Dockerize the Application

Create `Dockerfile`:

```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
```

Build and push image:

```bash
docker build -t yourdockerhubusername/user-microservice .
docker login
docker push yourdockerhubusername/user-microservice
```

### Step 4: CI/CD Pipeline (GitHub Actions)

- Create Workflow Directory

Inside your project root:


```bash
mkdir -p .github/workflows
cd .github/workflows
touch cicd.yml
```
- Add GitHub Actions Workflow

Create a file:

Create `.github/workflows/cicd.yml`:

Paste the following configuration:

```yaml
name: CI/CD Pipeline

on:
  push:
    branches:
      - "main"

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Install dependencies
        run: npm install

      - name: Run tests (optional)
        run: npm test || echo "No tests yet"

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_HUB_USERNAME }}
          password: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}

      - name: Build Docker image
        run: docker build -t ${{ secrets.DOCKER_HUB_USERNAME }}/user_microservice:latest .

      - name: Push Docker image
        run: docker push ${{ secrets.DOCKER_HUB_USERNAME }}/user_microservice:latest
```
Configure GitHub Secrets

Go to your GitHub repository:

Settings → Secrets and variables → Actions → New repository secret

Add:

| Secret Name     | Value                    |
| --------------- | ------------------------ |
| DOCKER_HUB_USERNAME | Your Docker Hub username |
| DOCKER_HUB_ACCESS_TOKEN | Your Docker Hub password |


- Trigger the Pipeline

Commit and push your code:

```bash
git add .
git commit -m "Add CI/CD pipeline"
git push origin main
```
- Verify Pipeline Execution

Go to GitHub → Actions tab

Click on the workflow run

Confirm:

✅ Build successful

✅ Docker image pushed to Docker Hub

### Step 5: Terraform Setup

Navigate to Terraform folder:

```bash
cd ../terraform
```

Initialize Terraform:

```bash
terraform init
```

Deploy infrastructure:

```bash
terraform apply
```

### Step 6: Access Application

After deployment, Terraform outputs:

```bash
alb_dns = "your-alb-dns-name"
```

Open in browser:

http://<alb_dns>

### Step 7: Destroy Infrastructure (Cost Control Best Practice)

After confirming the application is working, destroy resources to avoid unnecessary AWS charges:

````bash
terraform destroy
````

Type yes when prompted.

## Project Screenshots


### API user testing with Thuderclient

![Api testing](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260331_165418.jpg)


### Confirmation of Api user test on browser 

![Api User Confirmation](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260331_165805.jpg)

### Application Running on localhost in Browser

![Container Runnng on local host](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260331_161510.jpg)

### Application Running in Terminal

![Runnin container on terminal](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260331_170101.jpg)

### Application running with Dockerfile

![App with Dockerfile](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260331_174150.jpg)


### Image Pushed to Dockerhub

![Image Pushed to Dockerhub](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/1000734523.jpg)

### Image in Dockerhub

![Image in Dockerhub](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/1000734588.jpg)


### ECS Cluster (Running Task)

![ECS](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260402_094046.jpg)

### Load Balancer Configuration

![ALB](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260402_093235.jpg)

### Terraform Deployment Output

![Terraform](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/1000735727.jpg)

### Application Running live in the Cloud via ALB in Browser

![App in ALB](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260402_093052.jpg)

### CI/CD Pipeline Success

![CI/CD](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/GITHUB%20ACTIONS%20PIPELINE.png)

### Terraform Destroy Output

![Terraform Destroy](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260402_100251.jpg)

### ECS Cluster Terraform Destroy

![ECS Cluster Terraform Destroy](https://github.com/ChideraA080/user-microservice/blob/main/Screenshots_user_microservice_Project/IMG_20260402_113322.jpg)

## Security Best Practices

* Used `.gitignore` to exclude:

  * Terraform state files
  * `.env` files
  * `terraform.tfvars`
* Used `.dockerignore` to prevent unnecessary or sensitive files from being included in Docker images, reducing image size and improving security  
* Used environment variables and GitHub secrets
* Avoided hardcoding credentials

## Challenges & Solutions

**1. ECS + ALB Integration**

* Challenge: Understanding flow
* Solution: Broke into ALB → Target Group → ECS

**2. CI/CD Pipeline Setup**

* Challenge: Docker authentication
* Solution: Used GitHub Secrets

**3. App Not Accessible**

* Challenge: No browser access
* Solution: Fixed port + security group + ALB listener

##  Lessons Learned

* CI/CD improves deployment efficiency
* Terraform enables repeatable infrastructure
* ECS Fargate removes server management overhead
* ALB is essential for production traffic routing

## How to Fully Replicate This Project (End-to-End)

 Prerequisites
 
* AWS Account
* Terraform installed
* Docker installed
* AWS CLI configured (aws configure)
* Docker Hub account
* Git installed

Step 1: Clone Repository

```bash
git clone https://github.com/your-username/user-microservice.git
cd user-microservice
```
Step 2: Run Application Locally 

```bash
cd app
npm install
node app.js
```
Test in browser:

```bash
http://localhost:3000/api/users
```

Step 3: Build & Push Docker Image (Manual First Time)

```bash
docker build -t yourdockerhubusername/user-microservice ./app
docker push yourdockerhubusername/user-microservice
```
Step 4: Configure Terraform Variables

```bash
terraform/terraform.tfvars
```
Example

```bash
aws_region = "us-east-1"
docker_image = "yourdockerhubusername/user-microservice"
vpc_id = "your-vpc-id"
subnets = ["subnet-1", "subnet-2"]
```
Step 5: Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```
Type

```bash
yes
```
Step 6: Access Application

After deployment:

Copy ALB DNS from Terraform output

Open in browser:

```bash
http://<ALB-DNS>
```
Step 7: Test CI/CD Automation

Make a change in your app:

```bash
git add .
git commit -m "Update app"
git push origin main
```
Note: This triggers:

- GitHub Actions builds new image
- Pushes to Docker Hub

Step 8: Update Deployment

To reflect new changes:

```bash
terraform apply
```
(or update ECS service to pull latest image)

Step 9: Destroy Infrastructure (VERY IMPORTANT)

To avoid AWS charges:

```bash
terraform destroy
```
Type:

```bash
yes
```

## Future Improvements

* Add HTTPS with ACM
* Implement autoscaling
* Use Terraform remote backend (S3 + DynamoDB)
* Add monitoring (CloudWatch)

##  Conclusion

This project showcases my ability to:

* Build and containerize applications
* Automate deployments using CI/CD
* Provision infrastructure using Terraform
* Deploy scalable applications on AWS

It reflects my growing expertise in DevOps and my commitment to building production-ready systems.

