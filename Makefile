.PHONY: help build run dev stop clean logs test

# Default target
help:
	@echo "Available commands:"
	@echo "  build     - Build the Docker image"
	@echo "  run       - Run the application in production mode"
	@echo "  dev       - Run the application in development mode with hot reload"
	@echo "  stop      - Stop all running containers"
	@echo "  clean     - Remove containers and images"
	@echo "  logs      - Show application logs"
	@echo "  test      - Run tests"
	@echo "  shell     - Open shell in running container"
	@echo "  install   - Install dependencies locally"

# Build the Docker image
build:
	docker-compose build

# Run in production mode
run:
	docker-compose up -d
	@echo "Application running at http://localhost:8501"

# Run in development mode
dev:
	docker-compose --profile dev up readme2word-dev
	@echo "Development server running at http://localhost:8502"

# Stop all containers
stop:
	docker-compose down

# Clean up containers and images
clean:
	docker-compose down --rmi all --volumes --remove-orphans
	docker system prune -f

# Show logs
logs:
	docker-compose logs -f

# Run tests
test:
	python tests/run_all_tests.py

# Run quick tests for development
test-quick:
	python tests/run_all_tests.py --quick

# Run specific test suites
test-mermaid:
	python tests/test_mermaid.py

test-converter:
	python tests/test_converter.py

test-ui:
	python tests/test_ui.py

test-integration:
	python tests/test_integration.py

# Check dependencies
check-deps:
	python tests/run_all_tests.py --check-deps

# Open shell in running container
shell:
	docker-compose exec readme2word /bin/bash

# Install dependencies locally
install:
	pip install -r requirements.txt

# Quick start (build and run)
start: build run

# Development setup
setup-dev:
	python -m venv venv
	. venv/bin/activate && pip install -r requirements.txt
	@echo "Virtual environment created. Activate with: source venv/bin/activate" 