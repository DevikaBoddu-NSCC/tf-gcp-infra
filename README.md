# tf-gcp-infra
assignment 3- cloud computing   </br>
</br>
Prerequisites
* 		Terraform: Install Terraform </br>
*       gcloud cli : Install gcloud cli </br>
*       Create gcloud project using cli or console : gcloud projects create web-project-370718 </br>
*       Perform these steps to connect to the gcp console - </br>
                *       gcloud auth login </br>
                *       gcloud auth application-default login </br>
                *       gcloud config set project </br>
* 		Provider Credentials: Configure provider credentials in Terraform configuration files. </br></br>
  
Steps </br>
* 		Clone the Repository: git clone git@github.com:DevikaBoddu13/tf-gcp-infra.git  
* 		Initialize Terraform: terraform init 
* 		Review Configuration: Configure main.tf with infrastructure setup.
* 		Plan Infrastructure Changes: Run Terraform plan to see what changes will be applied
* 		Apply Infrastructure Changes: If the plan looks good, apply the changes: terraform apply
* 		Verify Infrastructure: After applying changes, verify that the infrastructure has been provisioned correctly using gcp console.
* 		Destroy Infrastructure (Optional): terraform destroy