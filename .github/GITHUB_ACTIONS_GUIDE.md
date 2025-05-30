# GitHub Actions CI/CD Pipeline Guide

This document explains the comprehensive GitHub Actions CI/CD pipeline setup for the README to Word Converter project.

## 🚀 Overview

The project includes multiple GitHub Actions workflows for:
- **Continuous Integration (CI)** - Testing and validation
- **Release Management** - Automated PyPI publishing
- **Docker** - Container building and publishing
- **Security** - Code analysis and vulnerability scanning
- **Dependency Management** - Automated dependency updates

## 📋 Workflows

### 1. CI Workflow (`.github/workflows/ci.yml`)

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`
- Manual dispatch

**Jobs:**
- **Test Matrix**: Tests across Python 3.8-3.12 on Ubuntu, Windows, macOS
- **Package Test**: Validates package building and installation
- **Docker Test**: Tests Docker image building and functionality
- **Security Scan**: Runs safety and bandit security checks
- **Lint and Format**: Code style and formatting validation

**Features:**
- Multi-platform testing
- Dependency caching
- Code coverage reporting
- Artifact uploading
- Comprehensive linting

### 2. Release Workflow (`.github/workflows/release.yml`)

**Triggers:**
- Git tags matching `v*` pattern
- Manual dispatch with version input

**Jobs:**
1. **Test**: Runs full test suite
2. **Build**: Creates distribution packages
3. **Publish to Test PyPI**: Tests publishing process
4. **Test Installation**: Validates Test PyPI installation
5. **Publish to PyPI**: Production release
6. **Create GitHub Release**: Automated release notes
7. **Notify**: Success/failure notifications

**Features:**
- Automated PyPI publishing
- Test PyPI validation
- GitHub release creation
- Changelog integration
- Artifact management

### 3. Docker Workflow (`.github/workflows/docker.yml`)

**Triggers:**
- Push to `main` or `develop` branches
- Git tags matching `v*`
- Pull requests to `main`
- Manual dispatch

**Jobs:**
- **Build and Test**: Docker image testing
- **Build and Push**: Multi-platform image publishing
- **Security Scan**: Trivy vulnerability scanning
- **Deploy Staging**: Automatic staging deployment
- **Deploy Production**: Production deployment on tags

**Features:**
- Multi-platform builds (AMD64, ARM64)
- GitHub Container Registry publishing
- Security vulnerability scanning
- Automated deployments
- Build provenance attestation

### 4. CodeQL Workflow (`.github/workflows/codeql.yml`)

**Triggers:**
- Push to `main` or `develop`
- Pull requests to `main`
- Weekly schedule (Mondays 1:30 AM UTC)

**Features:**
- Static code analysis
- Security vulnerability detection
- Extended security queries
- Automated security reporting

### 5. Dependency Review (`.github/workflows/dependency-review.yml`)

**Triggers:**
- Pull requests

**Features:**
- Dependency vulnerability scanning
- License compliance checking
- Automated security reviews

## 🔧 Required Secrets

### PyPI Publishing Secrets

1. **PYPI_API_TOKEN**
   - Go to [PyPI Account Settings](https://pypi.org/manage/account/token/)
   - Create new API token with "Entire account" scope
   - Add to GitHub repository secrets

2. **TEST_PYPI_API_TOKEN**
   - Go to [Test PyPI Account Settings](https://test.pypi.org/manage/account/token/)
   - Create new API token with "Entire account" scope
   - Add to GitHub repository secrets

### Setting Up Secrets

1. **Navigate to Repository Settings**:
   ```
   GitHub Repository → Settings → Secrets and variables → Actions
   ```

2. **Add New Repository Secret**:
   - Click "New repository secret"
   - Name: `PYPI_API_TOKEN`
   - Value: Your PyPI API token (starts with `pypi-`)
   - Click "Add secret"

3. **Repeat for Test PyPI**:
   - Name: `TEST_PYPI_API_TOKEN`
   - Value: Your Test PyPI API token

### Environment Protection

The release workflow uses GitHub Environments for additional security:

1. **Create Environments**:
   ```
   Repository Settings → Environments → New environment
   ```

2. **Environment Names**:
   - `test-pypi` - For Test PyPI publishing
   - `pypi` - For production PyPI publishing
   - `staging` - For staging deployments
   - `production` - For production deployments

3. **Environment Protection Rules**:
   - Required reviewers for production
   - Deployment branches (only `main` for production)
   - Environment secrets (if different from repository secrets)

## 🔄 Dependabot Configuration

The `.github/dependabot.yml` file configures automatic dependency updates:

**Update Schedules:**
- **Python dependencies**: Weekly on Mondays
- **Docker dependencies**: Weekly on Mondays  
- **GitHub Actions**: Weekly on Mondays

**Features:**
- Automatic PR creation
- Reviewer assignment
- Conventional commit messages
- Proper labeling

## 📝 Issue Templates

### Bug Report Template
- Structured bug reporting
- Environment information collection
- Reproduction steps
- Sample file requests

### Feature Request Template
- Feature description and motivation
- Use case documentation
- Implementation suggestions
- Impact assessment

### Pull Request Template
- Change type classification
- Testing checklist
- Documentation requirements
- Review guidelines

## 🚀 Usage Guide

### Triggering Workflows

**CI Workflow:**
```bash
# Automatically triggered on push/PR
git push origin main

# Manual trigger via GitHub UI
# Actions → CI → Run workflow
```

**Release Workflow:**
```bash
# Create and push tag
git tag v1.0.1
git push origin v1.0.1

# Or manual trigger with version input
# Actions → Release → Run workflow → Enter version
```

**Docker Workflow:**
```bash
# Automatically triggered on push
git push origin main

# Manual trigger via GitHub UI
# Actions → Docker → Run workflow
```

### Monitoring Workflows

1. **GitHub Actions Tab**: View all workflow runs
2. **Status Checks**: PR status indicators
3. **Email Notifications**: Workflow failure alerts
4. **Slack Integration**: Optional team notifications

### Debugging Failed Workflows

1. **Check Logs**: Click on failed job for detailed logs
2. **Re-run Jobs**: Re-run failed jobs if transient
3. **Local Testing**: Reproduce issues locally
4. **Secret Validation**: Verify secrets are correctly set

## 🔒 Security Best Practices

### Secrets Management
- Use repository secrets for sensitive data
- Rotate API tokens regularly
- Use environment-specific secrets when needed
- Never commit secrets to code

### Workflow Security
- Pin action versions to specific commits
- Use official actions when possible
- Limit workflow permissions
- Review third-party actions

### Dependency Security
- Enable Dependabot alerts
- Review dependency updates
- Use security scanning tools
- Monitor vulnerability databases

## 📊 Workflow Status Badges

Add status badges to your README:

```markdown
[![CI](https://github.com/vishalm/readme2readall/actions/workflows/ci.yml/badge.svg)](https://github.com/vishalm/readme2readall/actions/workflows/ci.yml)
[![Release](https://github.com/vishalm/readme2readall/actions/workflows/release.yml/badge.svg)](https://github.com/vishalm/readme2readall/actions/workflows/release.yml)
[![Docker](https://github.com/vishalm/readme2readall/actions/workflows/docker.yml/badge.svg)](https://github.com/vishalm/readme2readall/actions/workflows/docker.yml)
[![CodeQL](https://github.com/vishalm/readme2readall/actions/workflows/codeql.yml/badge.svg)](https://github.com/vishalm/readme2readall/actions/workflows/codeql.yml)
```

## 🛠️ Customization

### Modifying Workflows

1. **Test Matrix**: Adjust Python versions or OS in `ci.yml`
2. **Release Triggers**: Modify tag patterns in `release.yml`
3. **Docker Platforms**: Change target platforms in `docker.yml`
4. **Security Scans**: Adjust scan frequency in `codeql.yml`

### Adding New Workflows

1. Create new `.yml` file in `.github/workflows/`
2. Define triggers, jobs, and steps
3. Test with manual dispatch first
4. Document in this guide

### Environment Variables

Common environment variables used:
- `REGISTRY`: Container registry URL
- `IMAGE_NAME`: Docker image name
- `PYTHON_VERSION`: Default Python version

## 📞 Troubleshooting

### Common Issues

**PyPI Publishing Fails:**
- Verify API tokens are correct
- Check version number isn't already published
- Ensure package builds successfully

**Docker Build Fails:**
- Check Dockerfile syntax
- Verify base image availability
- Review build context

**Tests Fail:**
- Check Python version compatibility
- Verify dependencies are installed
- Review test environment setup

**Security Scans Fail:**
- Review vulnerability reports
- Update dependencies if needed
- Add exceptions for false positives

### Getting Help

1. **GitHub Actions Documentation**: [docs.github.com/actions](https://docs.github.com/actions)
2. **PyPI Publishing Guide**: [packaging.python.org](https://packaging.python.org/)
3. **Docker Documentation**: [docs.docker.com](https://docs.docker.com/)
4. **Project Issues**: [GitHub Issues](https://github.com/vishalm/readme2readall/issues)

## 🎉 Success Metrics

Track the success of your CI/CD pipeline:
- **Build Success Rate**: Percentage of successful builds
- **Test Coverage**: Code coverage percentage
- **Release Frequency**: Number of releases per month
- **Security Issues**: Number of vulnerabilities found/fixed
- **Deployment Time**: Time from commit to production

The GitHub Actions setup provides a robust, automated CI/CD pipeline that ensures code quality, security, and reliable releases for the README to Word Converter project. 