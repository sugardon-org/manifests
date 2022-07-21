.PHONY: all
all: lint

.PHONY: lint
lint: yamllint

.PHONY: yamllint
yamllint:
	yamllint -c .yamllint.yaml ./

.PHONY: kustomizebuild
kustomizebuild:
	./scripts/kustomizebuild.sh
