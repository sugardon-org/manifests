all: lint

lint: yamllint

yamllint:
	yamllint -c .yamllint.yaml ./
