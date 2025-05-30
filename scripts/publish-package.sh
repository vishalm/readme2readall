#!/bin/bash

# Publish script for README to Word Converter Python package

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

# Configuration
PACKAGE_NAME="readme2word"
TEST_PYPI_URL="https://test.pypi.org/simple/"
PYPI_URL="https://pypi.org/simple/"

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if twine is installed
    if ! command -v twine &> /dev/null; then
        print_error "twine is not installed. Install with: pip install twine"
        exit 1
    fi
    
    # Check if package is built
    if [ ! -d "dist" ] || [ -z "$(ls -A dist/)" ]; then
        print_error "No built package found in dist/. Run build script first."
        exit 1
    fi
    
    # Check if .pypirc exists
    if [ ! -f "$HOME/.pypirc" ]; then
        print_warning ".pypirc not found. You'll need to enter credentials manually."
    fi
    
    print_success "Prerequisites check completed!"
}

# Function to validate package before upload
validate_package() {
    print_status "Validating package before upload..."
    
    # Check package with twine
    twine check dist/*
    
    # Get package version
    version=$(python3 -c "import readme2word; print(readme2word.__version__)")
    print_status "Package version: $version"
    
    print_success "Package validation passed!"
}

# Function to check if version already exists
check_version_exists() {
    local repository=$1
    local url=$2
    
    print_status "Checking if version already exists on $repository..."
    
    version=$(python3 -c "import readme2word; print(readme2word.__version__)")
    
    # Try to check if version exists (this is a simple check)
    if pip index versions $PACKAGE_NAME --index-url $url 2>/dev/null | grep -q "$version"; then
        print_warning "Version $version already exists on $repository"
        return 1
    else
        print_success "Version $version is new on $repository"
        return 0
    fi
}

# Function to upload to Test PyPI
upload_to_test_pypi() {
    print_status "Uploading to Test PyPI..."
    
    if ! check_version_exists "Test PyPI" $TEST_PYPI_URL; then
        read -p "Version already exists. Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Upload cancelled."
            return 1
        fi
    fi
    
    twine upload --repository testpypi dist/*
    
    print_success "Package uploaded to Test PyPI!"
    
    version=$(python3 -c "import readme2word; print(readme2word.__version__)")
    echo ""
    print_status "Test installation:"
    echo "pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ $PACKAGE_NAME==$version"
    echo ""
    print_status "Test PyPI URL:"
    echo "https://test.pypi.org/project/$PACKAGE_NAME/"
}

# Function to upload to PyPI
upload_to_pypi() {
    print_status "Uploading to PyPI..."
    
    if ! check_version_exists "PyPI" $PYPI_URL; then
        print_error "Version already exists on PyPI. Please increment version number."
        exit 1
    fi
    
    # Final confirmation
    version=$(python3 -c "import readme2word; print(readme2word.__version__)")
    echo ""
    print_warning "⚠️  You are about to upload $PACKAGE_NAME v$version to PyPI (production)!"
    print_warning "This action cannot be undone!"
    echo ""
    read -p "Are you sure you want to continue? (yes/no): " -r
    if [[ ! $REPLY == "yes" ]]; then
        print_status "Upload cancelled."
        exit 0
    fi
    
    twine upload dist/*
    
    print_success "Package uploaded to PyPI! 🎉"
    
    echo ""
    print_status "Installation:"
    echo "pip install $PACKAGE_NAME"
    echo ""
    print_status "PyPI URL:"
    echo "https://pypi.org/project/$PACKAGE_NAME/"
}

# Function to test installation
test_installation() {
    local repository=$1
    
    print_status "Testing installation from $repository..."
    
    # Create temporary virtual environment
    temp_venv=$(mktemp -d)
    python3 -m venv "$temp_venv"
    source "$temp_venv/bin/activate"
    
    version=$(python3 -c "import readme2word; print(readme2word.__version__)")
    
    if [ "$repository" == "testpypi" ]; then
        pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ "$PACKAGE_NAME==$version"
    else
        pip install "$PACKAGE_NAME==$version"
    fi
    
    # Test import
    python3 -c "import readme2word; print(f'Successfully imported {readme2word.__name__} v{readme2word.__version__}')"
    
    # Test CLI
    readme2word --version
    
    deactivate
    rm -rf "$temp_venv"
    
    print_success "Installation test passed!"
}

# Function to show upload summary
show_summary() {
    print_status "Upload Summary:"
    echo ""
    
    version=$(python3 -c "import readme2word; print(readme2word.__version__)")
    echo "📦 Package: $PACKAGE_NAME"
    echo "🏷️  Version: $version"
    echo "📁 Files uploaded:"
    ls -la dist/
    echo ""
    
    print_success "Package is now available for installation!"
}

# Main publish function
publish_to_test() {
    print_status "Publishing to Test PyPI..."
    echo ""
    
    check_prerequisites
    echo ""
    
    validate_package
    echo ""
    
    upload_to_test_pypi
    echo ""
    
    show_summary
    
    print_success "Test PyPI publication completed! 🎉"
}

# Main publish function for production
publish_to_prod() {
    print_status "Publishing to PyPI (Production)..."
    echo ""
    
    check_prerequisites
    echo ""
    
    validate_package
    echo ""
    
    upload_to_pypi
    echo ""
    
    show_summary
    
    print_success "PyPI publication completed! 🎉"
}

# Parse command line arguments
case "${1:-help}" in
    "test")
        publish_to_test
        ;;
    "prod")
        publish_to_prod
        ;;
    "check")
        check_prerequisites
        validate_package
        ;;
    "test-install")
        test_installation "${2:-pypi}"
        ;;
    *)
        echo "Usage: $0 {test|prod|check|test-install}"
        echo ""
        echo "Commands:"
        echo "  test         - Upload to Test PyPI"
        echo "  prod         - Upload to PyPI (production)"
        echo "  check        - Check prerequisites and validate package"
        echo "  test-install - Test installation (test-install [testpypi|pypi])"
        echo ""
        echo "Examples:"
        echo "  $0 test                    # Upload to Test PyPI"
        echo "  $0 prod                    # Upload to PyPI"
        echo "  $0 test-install testpypi   # Test installation from Test PyPI"
        echo ""
        echo "Prerequisites:"
        echo "  1. Build package first: ./scripts/build-package.sh"
        echo "  2. Configure PyPI credentials in ~/.pypirc"
        echo "  3. Install twine: pip install twine"
        exit 1
        ;;
esac 