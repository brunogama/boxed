# Contributing Guidelines

Thank you for your interest in contributing to our project! This document provides guidelines and instructions for contributing.

## Reporting Issues

If you find a bug or have a suggestion:

1. Search the [issue tracker](../../issues) to ensure it hasn't been reported
2. Create a new issue with:
- A clear, descriptive title
- Detailed description of the issue
- Steps to reproduce (for bugs)
- Expected vs actual behavior
- Screenshots if applicable
- Environment details (OS, version, etc.)

## Pull Request Process

1. Fork the repository
2. Create a new branch from `main`:
```bash
git checkout -b feature/your-feature
```
3. Make your changes
4. Test your changes thoroughly
5. Commit your changes following our commit message conventions
6. Push to your fork and submit a pull request
7. Ensure the PR description clearly describes the changes and motivation

### PR Review Process

- All PRs require at least one review from a maintainer
- Address any requested changes promptly
- PRs will be merged once approved
- Ensure all tests pass and CI checks are green

## Code Style Guidelines

- Follow the existing code style in the project
- Use meaningful variable and function names
- Comment your code when necessary
- Keep functions focused and concise
- Write tests for new functionality
- Maintain consistent indentation
- Remove unused imports and variables
- Keep line length reasonable (max 120 characters)

## Commit Message Conventions

Follow the conventional commits specification:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation changes
- style: Code style changes (formatting, etc.)
- refactor: Code refactoring
- test: Adding or updating tests
- chore: Maintenance tasks

Example:
```
feat(auth): add user authentication endpoint

Implement JWT-based authentication for user login.
```

## Development Setup

1. Clone the repository:
```bash
git clone https://github.com/owner/repo.git
cd repo
```

2. Install dependencies:
```bash
# Add specific package manager commands here
```

3. Run tests:
```bash
# Add test commands here
```

4. Start the development environment:
```bash
# Add development server/environment commands here
```

## Questions or Need Help?

Feel free to reach out to the maintainers or create a discussion in the repository.

