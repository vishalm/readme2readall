#!/bin/bash

# README to Word Converter - Deployment Script
# This script helps deploy the application using Docker

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    print_success "Docker and Docker Compose are installed"
}

# Build the application
build_app() {
    print_status "Building the application..."
    docker-compose build
    print_success "Application built successfully"
}

# Deploy the application
deploy_app() {
    print_status "Deploying the application..."
    docker-compose up -d
    print_success "Application deployed successfully"
    print_status "Application is running at http://localhost:8501"
}

# Check application health
check_health() {
    print_status "Checking application health..."
    sleep 10
    
    if curl -f http://localhost:8501/_stcore/health &> /dev/null; then
        print_success "Application is healthy and running"
    else
        print_warning "Application might still be starting up. Check logs with: docker-compose logs"
    fi
}

# Show usage
show_usage() {
    echo "Usage: $0 [OPTION]"
    echo "Deploy README to Word Converter application"
    echo ""
    echo "Options:"
    echo "  build     Build the Docker image"
    echo "  deploy    Deploy the application"
    echo "  dev       Run in development mode"
    echo "  stop      Stop the application"
    echo "  logs      Show application logs"
    echo "  clean     Clean up containers and images"
    echo "  help      Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 deploy    # Build and deploy the application"
    echo "  $0 dev       # Run in development mode"
    echo "  $0 logs      # Show application logs"
}

# Main deployment function
main_deploy() {
    print_status "Starting deployment of README to Word Converter"
    check_docker
    build_app
    deploy_app
    check_health
    print_success "Deployment completed!"
    echo ""
    echo "🎉 Your README to Word Converter is now running!"
    echo "📱 Access the application at: http://localhost:8501"
    echo "📋 View logs with: docker-compose logs -f"
    echo "🛑 Stop the application with: docker-compose down"
}

# Handle command line arguments
case "${1:-deploy}" in
    "build")
        check_docker
        build_app
        ;;
    "deploy")
        main_deploy
        ;;
    "dev")
        print_status "Starting development mode..."
        check_docker
        docker-compose --profile dev up readme2word-dev
        ;;
    "stop")
        print_status "Stopping the application..."
        docker-compose down
        print_success "Application stopped"
        ;;
    "logs")
        docker-compose logs -f
        ;;
    "clean")
        print_status "Cleaning up..."
        docker-compose down --rmi all --volumes --remove-orphans
        docker system prune -f
        print_success "Cleanup completed"
        ;;
    "help"|"-h"|"--help")
        show_usage
        ;;
    *)
        print_error "Unknown option: $1"
        show_usage
        exit 1
        ;;
esac 