# Thin dispatcher over hack/*.sh. Logic lives in the scripts, not here.

.DEFAULT_GOAL := help

.PHONY: help init bootstrap setup rebuild restore raycast-import raycast-backup

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "} {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

init: bootstrap setup raycast-import ## One-shot setup for a new machine

bootstrap: ## Install Nix, generate local.nix, apply the flake, register SSH key
	./hack/bootstrap.sh

setup: ## Clone agent-kit and build Go from source
	./hack/setup.sh

rebuild: ## Apply configuration changes (darwin-rebuild switch)
	./hack/rebuild.sh

restore: ## Restore ghq-managed repositories
	./hack/ghq_restore.sh

raycast-import: ## Import configs/raycast/snippets.json into Raycast (idempotent)
	./hack/raycast-import.sh

raycast-backup: ## Export Raycast settings and save the .rayconfig into the repo
	./hack/raycast-backup.sh
