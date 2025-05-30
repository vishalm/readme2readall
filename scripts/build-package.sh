#!/bin/bash

# Build script for README to Word Converter Python package

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check Python version
    python_version=$(python3 --version 2>&1 | cut -d' ' -f2)
    print_status "Python version: $python_version"
    
    # Check if build tools are installed
    if ! python3 -c "import build" 2>/dev/null; then
        print_warning "build package not found. Installing..."
        pip install build
    fi
    
    if ! python3 -c "import twine" 2>/dev/null; then
        print_warning "twine package not found. Installing..."
        pip install twine
    fi
    
    print_success "Prerequisites check completed!"
}

# Function to clean previous builds
clean_build() {
    print_status "Cleaning previous builds..."
    
    rm -rf build/
    rm -rf dist/
    rm -rf *.egg-info/
    
    print_success "Build directories cleaned!"
}

# Function to run tests
run_tests() {
    print_status "Running tests..."
    
    if [ -d "tests" ]; then
        python3 -m pytest tests/ -v
        print_success "Tests passed!"
    else
        print_warning "No tests directory found, skipping tests"
    fi
}

# Function to validate package structure
validate_package() {
    print_status "Validating package structure..."
    
    # Check required files
    required_files=("README.md" "LICENSE" "pyproject.toml" "readme2word/__init__.py")
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            print_error "Required file missing: $file"
            exit 1
        fi
    done
    
    # Check package imports
    if ! python3 -c "import readme2word; print(f'Package version: {readme2word.__version__}')" 2>/dev/null; then
        print_error "Package import failed"
        exit 1
    fi
    
    print_success "Package structure validation passed!"
}

# Function to build the package
build_package() {
    print_status "Building package..."
    
    # Build source distribution and wheel
    python3 -m build
    
    print_success "Package built successfully!"
    
    # Show built files
    print_status "Built files:"
    ls -la dist/
}

# Function to check package
check_package() {
    print_status "Checking package with twine..."
    
    twine check dist/*
    
    print_success "Package check passed!"
}

# Function to show package info
show_package_info() {
    print_status "Package Information:"
    echo ""
    
    # Get version from package
    version=$(python3 -c "import readme2word; print(readme2word.__version__)")
    echo "📦 Package: readme2word"
    echo "🏷️  Version: $version"
    echo "📁 Files in dist/:"
    ls -la dist/
    echo ""
    
    # Show package size
    total_size=$(du -sh dist/ | cut -f1)
    echo "💾 Total size: $total_size"
    echo ""
    
    print_status "Package ready for upload!"
    echo ""
    echo "To upload to PyPI:"
    echo "  twine upload dist/*"
    echo ""
    echo "To upload to Test PyPI:"
    echo "  twine upload --repository testpypi dist/*"
}

# Main build function
build_all() {
    print_status "Starting package build process..."
    echo ""
    
    check_prerequisites
    echo ""
    
    clean_build
    echo ""
    
    validate_package
    echo ""
    
    run_tests
    echo ""
    
    build_package
    echo ""
    
    check_package
    echo ""
    
    show_package_info
    
    print_success "Build process completed successfully! 🎉"
}

# Parse command line arguments
case "${1:-build}" in
    "build")
        build_all
        ;;
    "clean")
        clean_build
        ;;
    "test")
        run_tests
        ;;
    "validate")
        validate_package
        ;;
    "check")
        check_package
        ;;
    "info")
        show_package_info
        ;;
    *)
        echo "Usage: $0 {build|clean|test|validate|check|info}"
        echo ""
        echo "Commands:"
        echo "  build     - Complete build process (default)"
        echo "  clean     - Clean build directories"
        echo "  test      - Run tests only"
        echo "  validate  - Validate package structure"
        echo "  check     - Check built package with twine"
        echo "  info      - Show package information"
        exit 1
        ;;
esac 