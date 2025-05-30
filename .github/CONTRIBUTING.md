# Contributing to README to Word Converter

Thank you for your interest in contributing to the README to Word Converter! This document provides guidelines and information for contributors.

## 🚀 Quick Start

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/readme2readall.git
   cd readme2readall
   ```
3. **Set up development environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -e .[dev]
   ```
4. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```
5. **Make your changes** and test them
6. **Submit a pull request**

## 📋 Development Setup

### Prerequisites
- Python 3.8 or higher
- Git
- Docker (optional, for containerized development)

### Local Development
```bash
# Clone the repository
git clone https://github.com/vishalm/readme2readall.git
cd readme2readall

# Create virtual environment
python -m venv venv
source venv/bin/activate

# Install in development mode
pip install -e .[dev]

# Run tests
pytest tests/

# Run the web interface
streamlit run app.py
```

### Docker Development
```bash
# Build and run development container
make dev

# Or using docker-compose directly
docker-compose --profile dev up readme2word-dev
```

## 🧪 Testing

### Running Tests
```bash
# Run all tests
make test

# Run specific test modules
pytest tests/test_converter.py -v
pytest tests/test_cli.py -v

# Run with coverage
pytest tests/ --cov=readme2word --cov-report=html
```

### Test Structure
- `tests/test_converter.py` - Core converter functionality
- `tests/test_cli.py` - Command-line interface tests
- `tests/test_ui.py` - Web interface tests
- `tests/test_integration.py` - End-to-end integration tests

### Writing Tests
- Use pytest for all tests
- Follow the existing test patterns
- Include both positive and negative test cases
- Mock external dependencies (like Mermaid API calls)
- Test edge cases and error conditions

## 📝 Code Style

### Python Code Style
We follow PEP 8 with some modifications:

```bash
# Format code with black
black readme2word/

# Check with flake8
flake8 readme2word/

# Sort imports with isort
isort readme2word/

# Type checking with mypy
mypy readme2word/
```

### Code Guidelines
- Use descriptive variable and function names
- Add docstrings to all public functions and classes
- Keep functions focused and small
- Use type hints where appropriate
- Follow existing patterns in the codebase

### Commit Messages
Follow conventional commit format:
```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test additions or changes
- `chore`: Build process or auxiliary tool changes

Examples:
```
feat(cli): add support for custom output directory
fix(converter): handle empty markdown files gracefully
docs(readme): update installation instructions
```

## 🔄 Pull Request Process

### Before Submitting
1. **Update documentation** if needed
2. **Add tests** for new functionality
3. **Run the full test suite** and ensure all tests pass
4. **Check code style** with linting tools
5. **Update CHANGELOG.md** if applicable

### Pull Request Guidelines
1. **Use the PR template** provided
2. **Link to related issues** using "Fixes #123" or "Closes #123"
3. **Provide clear description** of changes
4. **Include screenshots** for UI changes
5. **Keep PRs focused** - one feature/fix per PR
6. **Ensure CI passes** before requesting review

### Review Process
1. **Automated checks** must pass (CI, tests, linting)
2. **Code review** by maintainers
3. **Address feedback** promptly
4. **Squash commits** if requested
5. **Merge** after approval

## 🐛 Bug Reports

### Before Reporting
1. **Search existing issues** to avoid duplicates
2. **Test with latest version** of the package
3. **Gather relevant information** (OS, Python version, etc.)

### Bug Report Template
Use the provided bug report template and include:
- Clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Environment details
- Sample files if applicable

## ✨ Feature Requests

### Before Requesting
1. **Check existing issues** and discussions
2. **Consider the scope** - does it fit the project goals?
3. **Think about implementation** - is it feasible?

### Feature Request Template
Use the provided feature request template and include:
- Clear description of the feature
- Use case and motivation
- Proposed implementation (if any)
- Examples or mockups

## 📚 Documentation

### Types of Documentation
- **Code documentation** - Docstrings and comments
- **User documentation** - README, usage guides
- **API documentation** - Function and class documentation
- **Developer documentation** - This contributing guide

### Documentation Guidelines
- Keep documentation up-to-date with code changes
- Use clear, concise language
- Include examples where helpful
- Follow existing documentation patterns

## 🏗️ Project Structure

```
readme2readall/
├── 📦 Package
│   └── readme2word/           # Main package
│       ├── __init__.py        # Package initialization
│       ├── converter.py       # Core converter logic
│       ├── cli.py            # Command-line interface
│       └── web.py            # Web interface wrapper
├── 🧪 Tests
│   └── tests/                # Test suite
├── 🐳 Docker
│   ├── Dockerfile            # Container definition
│   └── docker-compose.yml    # Multi-container setup
├── ☸️ Infrastructure
│   └── infra/                # Kubernetes and deployment
├── 📚 Documentation
│   ├── README.md             # Main documentation
│   ├── CHANGELOG.md          # Version history
│   └── docs/                 # Additional documentation
└── 🔧 Configuration
    ├── pyproject.toml        # Package configuration
    ├── requirements.txt      # Dependencies
    └── Makefile             # Build automation
```

## 🔧 Build and Release

### Package Building
```bash
# Build package
make package-build

# Validate package
make package-validate

# Test locally
make install-local
```

### Release Process
1. **Update version** in `readme2word/__init__.py`
2. **Update CHANGELOG.md** with new version
3. **Create and push tag**:
   ```bash
   git tag v1.0.1
   git push origin v1.0.1
   ```
4. **GitHub Actions** will automatically build and publish

## 🤝 Community Guidelines

### Code of Conduct
- Be respectful and inclusive
- Welcome newcomers and help them learn
- Focus on constructive feedback
- Respect different viewpoints and experiences

### Communication
- **GitHub Issues** - Bug reports and feature requests
- **GitHub Discussions** - General questions and ideas
- **Pull Requests** - Code contributions and reviews

### Getting Help
- Check the documentation first
- Search existing issues and discussions
- Ask questions in GitHub Discussions
- Be specific about your problem or question

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.

## 🙏 Recognition

Contributors will be recognized in:
- GitHub contributors list
- CHANGELOG.md for significant contributions
- README.md acknowledgments section

Thank you for contributing to README to Word Converter! 🚀 