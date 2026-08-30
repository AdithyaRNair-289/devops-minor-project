# Automated Web Application Deployment using AWS, Terraform, Docker, and GitHub

This repo deploys a small Flask website to AWS automatically, using:
- **Terraform** to build the AWS infrastructure (VPC, Security Group, EC2)
- **Docker** to package the app
- **GitHub Actions** to automatically build + push the Docker image
- **EC2** to run the container and serve the site

## Folder structure

```
project/
├── app/
│   ├── app.py            # the website code
│   └── requirements.txt
├── Dockerfile             # instructions to build the container image
├── terraform/
│   ├── main.tf            # VPC, Security Group, EC2
│   ├── variables.tf
│   └── outputs.tf
├── .github/workflows/
│   └── docker-build-push.yml   # CI/CD pipeline
└── README.md
```

## Step-by-step: how to actually run this

### 1. Create a Docker Hub account & access token
1. Sign up at hub.docker.com (free).
2. Go to Account Settings → Security → New Access Token. Copy it.

### 2. Push this code to a new GitHub repository
```bash
cd project
git init
git add .
git commit -m "Initial commit: DevOps minor project"
git branch -M main
git remote add origin https://github.com/<your-username>/<your-repo>.git
git push -u origin main
```

### 3. Add secrets to GitHub (so the pipeline can log in to Docker Hub)
In your GitHub repo: **Settings → Secrets and variables → Actions → New repository secret**
- `DOCKERHUB_USERNAME` = your Docker Hub username
- `DOCKERHUB_TOKEN` = the access token from step 1

As soon as you push to `main`, the GitHub Actions pipeline (Phase 3) will automatically build the Docker image and push it to Docker Hub as `<your-username>/devops-minor-project:latest`. Check the **Actions** tab in GitHub to watch it run.

### 4. Set up AWS credentials on your own machine
Install the AWS CLI, then run:
```bash
aws configure
```
Enter your AWS Access Key ID, Secret Access Key, and default region (e.g. `ap-south-1`).

### 5. Create an EC2 Key Pair
In AWS Console → EC2 → Key Pairs → Create key pair. Download the `.pem` file and remember its **name**.

### 6. Find your own IP address
Visit whatismyip.com and copy your IPv4 address. Add `/32` to the end (e.g. `49.207.10.20/32`). This locks SSH access to only you.

### 7. Deploy the infrastructure with Terraform
```bash
cd terraform
terraform init
terraform plan \
  -var="key_name=<your-key-pair-name>" \
  -var="my_ip=<your-ip>/32" \
  -var="docker_image=<your-dockerhub-username>/devops-minor-project:latest"
terraform apply \
  -var="key_name=<your-key-pair-name>" \
  -var="my_ip=<your-ip>/32" \
  -var="docker_image=<your-dockerhub-username>/devops-minor-project:latest"
```
Type `yes` when prompted. Terraform will print the EC2's public IP when it finishes.

### 8. Visit your live app!
Open `http://<ec2-public-ip>:5000` in your browser. You should see the "Hello from AWS + Docker..." page.

### 9. Take your screenshots (for the "Expected Deliverables")
- GitHub Actions run succeeding (green checkmark)
- Docker Hub showing your pushed image
- Terminal output of `terraform apply`
- AWS Console showing the running EC2 instance
- Browser showing the live app at the EC2 public IP

### 10. Clean up (important — avoids AWS charges!)
```bash
terraform destroy -var="key_name=<your-key-pair-name>" -var="my_ip=<your-ip>/32" -var="docker_image=<your-dockerhub-username>/devops-minor-project:latest"
```

## How the pieces connect (the big picture)

```
You push code to GitHub
        │
        ▼
GitHub Actions builds a Docker image
        │
        ▼
Image is pushed to Docker Hub
        │
        ▼
Terraform builds AWS network + EC2 server
        │
        ▼
EC2 automatically pulls the image from Docker Hub and runs it
        │
        ▼
You visit the EC2 Public IP and see your live website
```
