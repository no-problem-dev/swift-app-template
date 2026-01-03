import APIContract
import Foundation

/// Profile API errors
public enum ProfileAPIError: APIContractError {
    /// Profile not found
    case notFound

    // MARK: - APIContractError

    public var statusCode: Int {
        switch self {
        case .notFound:
            return 404
        }
    }

    public var errorCode: String {
        switch self {
        case .notFound:
            return "PROFILE_NOT_FOUND"
        }
    }

    public var message: String {
        switch self {
        case .notFound:
            return "User profile not found"
        }
    }
}
