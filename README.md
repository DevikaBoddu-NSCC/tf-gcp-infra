# tf-gcp-infra

assignment 3- cloud computing   

Prerequisites
* 		Terraform: Install Terraform  
*       gcloud cli : Install gcloud cli  
*       Create gcloud project using cli or console : gcloud projects create web-project-370718 
*       Perform these steps to connect to the gcp console - 
                *       gcloud auth login 
                *       gcloud auth application-default login 
                *       gcloud config set project 
* 		Provider Credentials: Configure provider credentials in Terraform configuration file main.tf. 
  
Steps 
* 		Clone the Repository: git clone git@github.com:DevikaBoddu13/tf-gcp-infra.git  
* 		Initialize Terraform: terraform init 
* 		Review Configuration: Configure main.tf with infrastructure setup.
* 		Plan Infrastructure Changes: Run terraform plan to see what changes will be applied
* 		Apply Infrastructure Changes: If the plan looks good, apply the changes: terraform apply
* 		Verify Infrastructure: After applying changes, verify that the infrastructure has been provisioned correctly using gcp console.
* 		Destroy Infrastructure (Optional): terraform destroy