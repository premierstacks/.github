# Default shell
SHELL := /bin/bash

# Default goal
.DEFAULT_GOAL := never

# Goals
.PHONY: audit
audit: audit_npm

.PHONY: audit_npm
audit_npm: ./node_modules ./package-lock.json
	npm audit --audit-level info --include prod --include dev --include peer --include optional

.PHONY: check
check: lint audit

.PHONY: clean
clean:
	rm -rf ./node_modules
	rm -rf ./package-lock.json

.PHONY: commit
commit: fix check

.PHONY: development
development:

.PHONY: fix
fix: fix_eslint fix_prettier

.PHONY: fix_eslint
fix_eslint: ./node_modules/.bin/eslint ./eslint.config.js
	./node_modules/.bin/eslint --fix .

.PHONY: fix_prettier
fix_prettier: ./node_modules/.bin/prettier ./prettier.config.js
	./node_modules/.bin/prettier -w .

.PHONY: lint
lint: lint_eslint lint_prettier

.PHONY: lint_eslint
lint_eslint: ./node_modules/.bin/eslint ./eslint.config.js
	./node_modules/.bin/eslint .

.PHONY: lint_prettier
lint_prettier: ./node_modules/.bin/prettier ./prettier.config.js
	./node_modules/.bin/prettier -c .

.PHONY: local
local:

.PHONY: production
production:

.PHONY: staging
staging:

.PHONY: testing
testing:

# Dependencies
./node_modules ./node_modules/.bin/eslint ./node_modules/.bin/prettier: ./package-lock.json
	npm install --install-links --include prod --include dev --include peer --include optional
	touch ./package-lock.json
	touch ./node_modules
	touch ./node_modules/.bin/*

./package-lock.json: ./package.json
	rm -rf ./node_modules
	rm -rf ./package-lock.json
	npm update --install-links --include prod --include dev --include peer --include optional
	touch ./package-lock.json
