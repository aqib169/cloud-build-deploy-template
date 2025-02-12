## Local Setup with Docker-compose

Ensure you have Docker installed on your system:
- Clone the repo
   ```bash
      git clone git@github.com:bluesoftllc/devops_templates.git
   ```
- Go to the project directory
   ```bash
      cd .\devops_templates
   ```
- Create .env file and add the following URL for local setup
   ```bash
   DATABASE_URL=postgres://postgres_user:<postgres_pwd>@postgres:5432/postgres
   ```
- If using windows Docker Desktop should be running then:
   ```bash
      docker-compose up --build -d
   ```

## Setting Up on Cloud Run

-  Authenticate with the GCP account and setup the project
   ```bash
   gcloud auth application-default login
   ```
-  Build Docker image for Django and push to artifact registry
   ```bash
   docker build -t gcr.io/[Your-Project-id-here]/django-image:latest .
   ```
   ```bash
   docker push -t gcr.io/[Your-Project-id-here]/django-image:latest
   ```

-  Go to terraform folder
-  Open var.tf file and set the project-id, image-tag name and other variables according to the need.
-  Initialize the terraform
   ```bash
   terraform init
   ```  
-  Apply the terraform to run the resources
   ```bash
   terraform apply
   ``` 

-  When you have to destroy the infrastructure, you need to (transfer if need) undo the changes the resources made, for this infra you need to destroy the database manaully from the console beacause Django app using that database and cause error while destroying the terraform script.
-  After changes
   ```bash
   terraform destroy
   ```