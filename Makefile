all: help
.PHONY: help review-start review-stop

# Change this value to match your domain:
CNAME := review.man.wtf

# Set this to the path where built sources are placed:
SRC_DIR ?= public

SHELL := /bin/bash
DISTRIBUTION_ID := $(shell aws cloudfront list-distributions --query "DistributionList.Items[?contains(Aliases.Items, '*.$(CNAME)')].Id" --output text)
ALIAS_SLUG := $(shell sed -e 's/[^a-z0-9-]/-/g' -e 's/--*/-/g' <<< $(ALIAS))

help:
	@printf 'Start and stop review applications.\n\n'
	@printf "\tStart a review app:\n\t\tmake review-start ALIAS='my-review-app-alias'\n\n"
	@printf "\tStop a review app:\n\t\tmake review-stop ALIAS='my-review-app-alias'\n\n"

guard-%:
	@if [ -z '$($*)' ]; then \
		printf '\e[31;1mERROR:\e[22m You are required to set variable \e[1m%s\e[22m!\e[0m\n' '$*'; \
		exit 1; \
	fi

review-start: guard-ALIAS
	@printf '\e[34mSyncing files to S3: \e[33;1m%s\e[0m\n' 's3://$(CNAME)/$(ALIAS_SLUG)'
	@aws s3 sync $(SRC_DIR)/ s3://$(CNAME)/$(ALIAS_SLUG) --delete

	@printf '\e[34mCreating CloudFront invalidation...\e[0m\n'
	@aws cloudfront create-invalidation --paths '/*' --distribution-id $(DISTRIBUTION_ID) --output text

	@printf '\e[32mReview application available at: \e[1mhttps://%s.%s/\e[0m\n' '$(ALIAS_SLUG)' '$(CNAME)'

review-stop: guard-ALIAS
	@printf '\e[34mDeleting files from S3: \e[33;1m%s\e[0m\n' 's3://$(CNAME)/$(ALIAS_SLUG)'
	@aws s3 rm s3://$(CNAME)/$(ALIAS_SLUG) --recursive

	@printf '\e[34mCreating CloudFront invalidation...\e[0m\n'
	@aws cloudfront create-invalidation --paths '/*' --distribution-id $(DISTRIBUTION_ID) --output text
