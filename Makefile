################################################################################
# Variables
################################################################################

# set DOCKER_CLI_HINTS=false to disable docker for desktop messages
# ref.: https://forums.docker.com/t/how-to-turn-off-the-whats-new-message/140860
export DOCKER_CLI_HINTS = false

# Image name
IMAGE_NAME=dotfiles-test

# Container name
CONTAINER_NAME=dotfiles-test

# Path to the tests in the container
TEST_PATH=/home/testuser/.tests/
TESTRESULT_PATH=/home/testuser/.test_results/

################################################################################
# Targets
################################################################################

# Helper
################################################################################

.PHONY: gen_keybinding_docs
gen_keybinding_docs:
	@`pwd`/.dotfileassets/gen_keymapping_md_table.sh

# Tests
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
	@mkdir -p `pwd`/.test_results
	@docker run --name $(CONTAINER_NAME) -i -v `pwd`/.test_results:$(TESTRESULT_PATH) --rm $(IMAGE_NAME) bash -c "bats --formatter junit $(TEST_PATH) | tee $(TESTRESULT_PATH)/unit-test-result.xml"

# Run all tests and open shell in container for debugging
.PHONY: test
test-debug: build
	@echo "Running tests..."
	@docker run --name $(CONTAINER_NAME) -it --rm $(IMAGE_NAME) bash -c "bats -x -p -T --print-output-on-failure $(TEST_PATH); bash"

# Remove the Docker image
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -r `pwd`/.test_results
	@docker rm -fv $(CONTAINER_NAME)
	@docker rmi -f $(IMAGE_NAME)

# Open shell in the build image
.PHONY: shell
shell: build
	@docker run -it --rm $(IMAGE_NAME) bash
