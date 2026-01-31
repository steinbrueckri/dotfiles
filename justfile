# Default recipe (runs when you type just `just`)
default: test

# Docker image name
image_name := "dotfiles-test"
container_name := "dotfiles-test"
test_path := "/home/testuser/.tests/"
testresult_path := "/home/testuser/.test_results/"

# Set environment for Docker CLI
export DOCKER_CLI_HINTS := "false"
export DOCKER_BUILDKIT := "1"

# Build the Docker image
build:
    @echo "Building Docker image..."
    docker build -t {{image_name}} -f .Dockerfile .

# Run tests (excludes slow tests)
test: build
    @echo "Running tests (excluding slow)..."
    @mkdir -p .test_results
    docker run --name {{container_name}} -i \
        -v {{justfile_directory()}}/.test_results:{{testresult_path}} \
        --rm {{image_name}} bash -c \
        "pytest -m 'not slow' --junitxml={{testresult_path}}/unit-test-result.xml"

# Run all tests including slow ones
test-all: build
    @echo "Running all tests..."
    @mkdir -p .test_results
    docker run --name {{container_name}} -i \
        -v {{justfile_directory()}}/.test_results:{{testresult_path}} \
        --rm {{image_name}} bash -c \
        "pytest -v --junitxml={{testresult_path}}/unit-test-result.xml"

# Run tests in debug mode (drops to shell on failure)
test-debug: build
    @echo "Running tests in debug mode..."
    docker run --name {{container_name}} -it --rm {{image_name}} bash -c \
        "pytest -vv -s --tb=short || bash"

# Open interactive shell in the container
shell: build
    @echo "Opening shell in container..."
    docker run -it --rm {{image_name}} bash

# Clean up Docker resources and test results
clean:
    @echo "Cleaning up..."
    @rm -rf .test_results
    @docker rm -fv {{container_name}} 2>/dev/null || true
    @docker rmi -f {{image_name}} 2>/dev/null || true

# Lint markdown files
lint-md:
    @echo "Linting markdown..."
    docker run --rm -v {{justfile_directory()}}:/workdir davidanson/markdownlint-cli2 "README.md"

# Lint Python files
lint-py:
    @echo "Linting Python files..."
    @uvx run ruff check .
    @uvx run ruff format --check .
    @uvx run ruff lint .
    @uvx run ruff type check .
    @uvx run ruff safety check .
    @uvx run ruff security check .
    @uvx run ruff security check .

# Run specific test marker
test-marker marker: build
    @echo "Running tests with marker: {{marker}}"
    docker run -it --rm {{image_name}} pytest -m {{marker}} -v

# List all available recipes
list:
    @just --list
