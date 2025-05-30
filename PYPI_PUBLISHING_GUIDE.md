# PyPI Publishing Guide for README to Word Converter

This guide walks you through the complete process of publishing the `readme2word` package to PyPI.

## 📋 Prerequisites

### 1. PyPI Account Setup
1. **Create PyPI Account**: [https://pypi.org/account/register/](https://pypi.org/account/register/)
2. **Create Test PyPI Account**: [https://test.pypi.org/account/register/](https://test.pypi.org/account/register/)
3. **Enable 2FA**: Highly recommended for security

### 2. API Tokens
1. **PyPI API Token**:
   - Go to [https://pypi.org/manage/account/token/](https://pypi.org/manage/account/token/)
   - Create new token with scope "Entire account"
   - Save the token securely

2. **Test PyPI API Token**:
   - Go to [https://test.pypi.org/manage/account/token/](https://test.pypi.org/manage/account/token/)
   - Create new token with scope "Entire account"
   - Save the token securely

### 3. Configure Credentials

Create `~/.pypirc` file:

```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
username = __token__
password = pypi-your-api-token-here

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-your-test-api-token-here
```

### 4. Install Build Tools

```bash
pip install build twine
```

## 🏗️ Package Structure

The package is structured as follows:

```
readme2readall/
├── 📦 Package Files
│   ├── setup.py                    # Legacy setup script
│   ├── pyproject.toml              # Modern package configuration
│   ├── MANIFEST.in                 # Package inclusion rules
│   ├── LICENSE                     # MIT license
│   ├── CHANGELOG.md                # Version history
│   └── README_PYPI.md              # PyPI-specific README
├── 📁 Source Code
│   └── readme2word/                # Main package
│       ├── __init__.py             # Package initialization
│       ├── converter.py            # Core converter
│       ├── cli.py                  # Command-line interface
│       └── web.py                  # Web interface wrapper
├── 🔧 Build Scripts
│   └── scripts/
│       ├── build-package.sh        # Package building
│       └── publish-package.sh      # Publishing automation
└── 🧪 Tests
    └── tests/                      # Test suite
```

## 🚀 Publishing Process

### Step 1: Prepare the Package

1. **Update Version**:
   ```bash
   # Edit readme2word/__init__.py
   __version__ = "1.0.1"  # Increment version
   ```

2. **Update Changelog**:
   ```bash
   # Edit CHANGELOG.md
   ## [1.0.1] - 2024-05-27
   ### Fixed
   - Bug fixes and improvements
   ```

3. **Validate Package**:
   ```bash
   make package-validate
   # or
   ./scripts/build-package.sh validate
   ```

### Step 2: Build the Package

```bash
# Clean previous builds
make package-clean

# Build package
make package-build

# Or use script directly
./scripts/build-package.sh
```

This will create:
- `dist/readme2word-1.0.0.tar.gz` (source distribution)
- `dist/readme2word-1.0.0-py3-none-any.whl` (wheel distribution)

### Step 3: Test on Test PyPI

```bash
# Upload to Test PyPI
make publish-test
# or
./scripts/publish-package.sh test
```

### Step 4: Test Installation

```bash
# Test installation from Test PyPI
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ readme2word

# Test the package
readme2word --version
readme2word --help
```

### Step 5: Publish to PyPI

```bash
# Upload to PyPI (production)
make publish-prod
# or
./scripts/publish-package.sh prod
```

## 🔧 Available Commands

### Make Commands

```bash
# Package building
make package-build        # Build the package
make package-clean        # Clean build artifacts
make package-validate     # Validate package structure
make package-check        # Check built package with twine

# Publishing
make publish-test         # Publish to Test PyPI
make publish-prod         # Publish to PyPI
make publish-check        # Check publishing prerequisites

# Local installation
make install-local        # Install package locally
make install-local-dev    # Install with dev dependencies
```

### Script Commands

```bash
# Build script
./scripts/build-package.sh build      # Complete build process
./scripts/build-package.sh clean      # Clean build directories
./scripts/build-package.sh test       # Run tests only
./scripts/build-package.sh validate   # Validate package structure
./scripts/build-package.sh check      # Check built package
./scripts/build-package.sh info       # Show package information

# Publish script
./scripts/publish-package.sh test     # Upload to Test PyPI
./scripts/publish-package.sh prod     # Upload to PyPI
./scripts/publish-package.sh check    # Check prerequisites
```

## 📊 Package Information

### Current Package Details

- **Name**: `readme2word`
- **Version**: `1.0.0`
- **License**: MIT
- **Python**: 3.8+
- **Dependencies**: streamlit, python-docx, markdown, beautifulsoup4, requests, Pillow

### Entry Points

The package provides two command-line tools:
- `readme2word` - Main CLI interface
- `readme2word-web` - Web interface launcher

### Installation Options

```bash
# Basic installation
pip install readme2word

# With development tools
pip install readme2word[dev]

# With Docker support
pip install readme2word[docker]

# With Kubernetes support
pip install readme2word[kubernetes]

# Everything
pip install readme2word[all]
```

## 🧪 Testing Checklist

Before publishing, ensure:

- [ ] **Package builds successfully**: `make package-build`
- [ ] **All tests pass**: `make test`
- [ ] **Package validates**: `make package-validate`
- [ ] **CLI works**: `readme2word --version`
- [ ] **Web interface works**: `readme2word --web`
- [ ] **Import works**: `python -c "import readme2word"`
- [ ] **Version is correct**: Check `__version__` in `__init__.py`
- [ ] **Changelog updated**: Add entry for new version
- [ ] **Test PyPI upload works**: `make publish-test`
- [ ] **Test installation works**: Install from Test PyPI and test

## 🔒 Security Considerations

1. **API Tokens**: Never commit API tokens to version control
2. **2FA**: Enable two-factor authentication on PyPI accounts
3. **Token Scope**: Use project-scoped tokens when possible
4. **Regular Rotation**: Rotate API tokens periodically

## 📈 Post-Publication

### Monitor Package

1. **PyPI Page**: [https://pypi.org/project/readme2word/](https://pypi.org/project/readme2word/)
2. **Download Stats**: Monitor package downloads
3. **Issues**: Watch for user-reported issues
4. **Dependencies**: Monitor for security updates

### Update Documentation

1. **GitHub README**: Update installation instructions
2. **Release Notes**: Create GitHub release
3. **Documentation**: Update any external documentation

### Version Management

Follow semantic versioning:
- **Major** (1.0.0): Breaking changes
- **Minor** (1.1.0): New features, backward compatible
- **Patch** (1.0.1): Bug fixes, backward compatible

## 🚨 Troubleshooting

### Common Issues

**Build Fails**:
```bash
# Check package structure
./scripts/build-package.sh validate

# Check dependencies
pip install -r requirements.txt
```

**Upload Fails**:
```bash
# Check credentials
./scripts/publish-package.sh check

# Verify package
twine check dist/*
```

**Version Already Exists**:
```bash
# Increment version in __init__.py
# Rebuild package
make package-clean && make package-build
```

**Import Errors**:
```bash
# Check package installation
pip show readme2word

# Reinstall in development mode
pip install -e .
```

## 📞 Support

For issues with publishing:

1. **Package Issues**: [GitHub Issues](https://github.com/vishalm/readme2readall/issues)
2. **PyPI Help**: [PyPI Help](https://pypi.org/help/)
3. **Packaging Guide**: [Python Packaging Guide](https://packaging.python.org/)

## 🎉 Success!

Once published, your package will be available:

- **Installation**: `pip install readme2word`
- **PyPI Page**: https://pypi.org/project/readme2word/
- **Documentation**: Package README on PyPI

Congratulations on publishing your Python package! 🚀 