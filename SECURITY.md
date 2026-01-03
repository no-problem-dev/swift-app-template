# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it responsibly:

1. **Do not** open a public issue
2. Email the maintainers directly or use GitHub's private vulnerability reporting feature
3. Include detailed information about the vulnerability
4. Allow reasonable time for a fix before public disclosure

## Security Best Practices

When using this template:

### Firebase Configuration

- Never commit `GoogleService-Info.plist` to public repositories
- Use environment variables for sensitive configuration
- Enable App Check in production

### API Security

- All API endpoints require Firebase Authentication
- Use HTTPS in production
- Validate all user inputs server-side

### Secrets Management

- Use `.env` files for local development (gitignored)
- Use GitHub Secrets for CI/CD
- Use Cloud Secret Manager for production

## Dependencies

We regularly update dependencies to address security vulnerabilities. Run `swift package update` periodically to get the latest security patches.
