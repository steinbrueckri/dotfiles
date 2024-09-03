# Docker image name
IMAGE_NAME=dotfiles-test

# Default branch and Neovim version to use
BRANCH=feat/testing
NVIM_VERSION=stable

# Default target: build the Docker image and run the tests
.PHONY: all
all: test

# Build the Docker image
.PHONY: build
build:
	@echo "Building Docker image..."
	docker build --build-arg BRANCH=$(BRANCH) --build-arg NVIM_VERSION=$(NVIM_VERSION) -t $(IMAGE_NAME) .

# Run all tests
.PHONY: test
test: build
	@echo "Running tests..."
	docker run --rm $(IMAGE_NAME) bash -c "bats /home/testuser/tests/*.bats"

# Remove the Docker image
.PHONY: clean
clean:
	@echo "Cleaning up..."
	docker rmi $(IMAGE_NAME)

# Open shell in the build image as testuser
.PHONY: shell
shell: build
	docker run -it --rm $(IMAGE_NAME) bash

# Open shell in the build image as root user
.PHONY: shell
shell-root: build
	docker run -it --user root --rm $(IMAGE_NAME) bash

# Display help
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make build            - Build the Docker image (use BRANCH=<branch-name> and NVIM_VERSION=<stable|nightly> to specify branch and Neovim version)"
	@echo "  make test             - Run all tests"
	@echo "  make test-specific    - Run specific tests (e.g., make test-specific BATS_TEST_PATH=tests/test_prompt.bats)"
	@echo "  make clean            - Remove the Docker image"
	@echo "  make help             - Display this help message"
