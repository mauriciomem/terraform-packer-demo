CURRENT_DIR = $(shell pwd)
WAIT = $(shell sleep 1)

.PHONY: clean apply/% plan/% destroy/% purge/%

ifndef AWS_ACCESS_KEY_ID
  $(error AWS_ACCESS_KEY_ID env variable required but not found)
endif
ifndef AWS_REGION
  $(error AWS_REGION variable required but not found)
endif
ifndef AWS_SECRET_ACCESS_KEY
  $(error AWS_SECRET_ACCESS_KEY env variable required but not found)
endif
ifndef AWS_SESSION_TOKEN
  $(error AWS_SESSION_TOKEN variable required but not found)
endif
ifndef GOOGLE_APPLICATION_CREDENTIALS
  $(error GOOGLE_APPLICATION_CREDENTIALS variable required but not found)
endif

clean:
	find . -name .terraform -type d -prune -exec rm -rf {} \;
	find . -name .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup -type f -prune -exec rm -rf {} \;

plan/%: 
	@echo INFO: plan::planning infrastructure changes to $(*)
	cd $(*) && terraform plan

apply/%: 
	@echo INFO: apply::applying infrastructure changes to $(*)
	cd $(*) && terraform apply --auto-approve

validate/%:
	@echo INFO: apply::applying infrastructure changes to $(*)
	cd $(*) && terraform validate

destroy/%:
	@echo INFO: destroy::destroying infrastructure on $(*)
	cd $(*) && terraform destroy --auto-approve

purge/%:
	@echo INFO: purge::destroying infrastructure and removing runtime exec files on $(*)
	$(MAKE) destroy/$(*)	
	$(MAKE) clean

deploy-demo/%:
	@echo INFO: deploy-demo::deploy acme corp complete infrastructure
	@echo INFO: deploy-demo::deploy packer images
	packer build $(CURRENT_DIR)/packer
	@echo INFO: deploy-demo::apply terraform
	$(WAIT)
        docker run --rm -e "AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID" \
		-e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY \
		-e AWS_SESSION_TOKEN=$$AWS_SESSION_TOKEN \
		-e AWS_REGION=$$AWS_REGION \
		hashicorp/terraform:1.7.5 terraform apply $(CURRENT_DIR)/terraform/aws
    docker run --rm -e GOOGLE_APPLICATION_CREDENTIALS=$$GOOGLE_APPLICATION_CREDENTIALS \
		hashicorp/terraform:1.7.5 terraform apply $(CURRENT_DIR)/terraform/gcp

deploy-tf/%:
	@echo INFO: deploy-demo::apply terraform in AWS & GCP
        docker run --rm -e "AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID" \
		-e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY \
		-e AWS_SESSION_TOKEN=$$AWS_SESSION_TOKEN \
		-e AWS_REGION=$$AWS_REGION \
		hashicorp/terraform:1.7.5 terraform apply $(CURRENT_DIR)/terraform/aws
    	docker run --rm -e GOOGLE_APPLICATION_CREDENTIALS=$$GOOGLE_APPLICATION_CREDENTIALS \
		hashicorp/terraform:1.7.5 terraform apply $(CURRENT_DIR)/terraform/gcp
