################################################################################
# Variables
################################################################################

# set DOCKER_CLI_HINTS=false to disable docker for desktop messages
# ref.: https://forums.docker.com/t/how-to-turn-off-the-whats-new-message/140860
export DOCKER_CLI_HINTS = false

# Docker image name
IMAGE_NAME=dotfiles-test

# Path to the tests in the container
TEST_PATH=/home/testuser/.tests/

################################################################################
# Targets
################################################################################

# Default target: build the Docker image and run the tests
.PHONY: all
all: test

.PHONY: lint-md
lint-md:
	@docker run --rm -v `pwd`:/workdir davidanson/markdownlint-cli2 "README.md"

# Build the Docker image
.PHONY: build
build:
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME) -f .Dockerfile .

# Run all tests
.PHONY: test
test: build
	@echo "Running tests..."
	@docker run -it --rm $(IMAGE_NAME) bash -c "bats -x -p -T --print-output-on-failure $(TEST_PATH)"

# Run all tests
.PHONY: test
test-debug: build
	@echo "Running tests..."
	@docker run -it --rm $(IMAGE_NAME) bash -c "bats -x -p -T --print-output-on-failure $(TEST_PATH); bash"

# Remove the Docker image
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@docker rmi $(IMAGE_NAME)

# Open shell in the build image
.PHONY: shell
shell: build
	@docker run -it --rm $(IMAGE_NAME) bash
