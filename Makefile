.PHONY: all
all: lint

.PHONY: lint
lint: yamllint helmlint

.PHONY: yamllint
yamllint:
	yamllint -c .yamllint.yaml ./

.PHONY: helmlint
helmlint:
	./scripts/helmlint.sh

.PHONY: kustomizebuild
kustomizebuild:
	./scripts/kustomizebuild.sh
