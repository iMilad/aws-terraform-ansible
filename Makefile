help:
	@echo "Usage: make <command> [ENV=<terraform-workspace>]"
	@echo ""
	@echo "Common commands:"
	@echo "   plan               runs terraform plan for a terraform workspace"
	@echo "   apply              runs terraform apply for a terraform workspacet"
	@echo "   destroy            \033[31mterminate\033[0m all infrastructure"

	@echo ""
	@echo "Future commands:"
	@echo "   check              check all varialbles and terraform installation"

plan:
	@terraform fmt

	@echo "Initializing..."
	@terraform init

	@echo 'Switching to the [$(value ENV)] environment ...'
	@terraform workspace select $(value ENV)

	@terraform plan  \
  	  -var-file="envs/$(value ENV).tfvars" \
		-out $(value ENV).plan


apply:
	@echo 'Switching to the [$(value ENV)] environment ...'
	@terraform workspace select $(value ENV)

	@echo "Will be applying the following to [$(value ENV)] environment:"
	@terraform show $(value ENV).plan

	@terraform apply $(value ENV).plan
	@rm $(value ENV).plan


destroy:
	@echo "Switching to the [$(value ENV)] environment ..."
	@terraform workspace select $(value ENV)

	@read -p "🔺 Are you really sure you want to delete resources in [$(value ENV)] environment? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac

	@echo "\033[31mRunning terraform destroy ...\033[0m"
	@terraform destroy \
		-var-file="envs/$(value ENV).tfvars"
