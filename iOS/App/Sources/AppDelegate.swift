import Authentication
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        AuthenticationUseCaseImpl.handleGoogleSignInURL(url)
    }
}
