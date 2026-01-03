# Contributing to Swift App Template

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Follow the setup instructions in [README.md](README.md)

## Development Workflow

### Branch Naming

- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring
- `test/` - Test additions or fixes

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add user authentication
fix: resolve login timeout issue
docs: update setup instructions
refactor: simplify API client
test: add unit tests for auth service
```

### Pull Request Process

1. Create a feature branch from `main`
2. Make your changes with clear, focused commits
3. Ensure all tests pass
4. Update documentation if needed
5. Submit a pull request with a clear description

## Code Style

### Swift

- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use SwiftLint for consistent formatting
- Prefer `let` over `var` when possible
- Use meaningful variable and function names

### Architecture

- Follow Clean Architecture principles
- Keep UI logic in Presentation layer
- Business logic belongs in UseCases
- Data access through Repository pattern

## Testing

- Write unit tests for new features
- Maintain existing test coverage
- Run tests before submitting PR:

```bash
# iOS tests
/ios-dev:ios-test

# Server tests
make server-test
```

## Reporting Issues

When reporting issues, please include:

- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Environment details (Xcode version, iOS version, etc.)

## Questions?

See [SUPPORT.md](SUPPORT.md) for how to get help.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
