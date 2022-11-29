init:
	terraform init

plan:
	terraform plan -var-file fixtures.west-europe.tfvars -out tfplan

apply:
	terraform apply tfplan

destroy:
	terraform destroy -var-file fixtures.west-europe.tfvars
