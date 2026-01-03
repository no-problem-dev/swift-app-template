# Support

## Documentation

- [README.md](README.md) - Setup and usage instructions
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [docs/](docs/) - Additional documentation

## Getting Help

### Issues

For bugs and feature requests, please [open an issue](../../issues/new/choose) using the appropriate template.

### Discussions

For questions, ideas, and general discussion, use [GitHub Discussions](../../discussions) if enabled.

## Common Issues

### Build Errors

1. Ensure Xcode 16+ is installed
2. Run `make setup` to regenerate project files
3. Clean build folder: `Cmd + Shift + K` in Xcode

### Firebase Setup

1. Verify `GoogleService-Info.plist` is in `iOS/App/`
2. Run `make xcode-generate` after adding the plist
3. Check Firebase Console for correct bundle ID

### Emulator Issues

1. Ensure Firebase CLI is installed: `npm install -g firebase-tools`
2. Check emulator status: `make emulator-status`
3. Kill stuck processes: `make kill-ports`

## Resources

- [Swift Documentation](https://swift.org/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Firebase iOS Documentation](https://firebase.google.com/docs/ios/setup)
