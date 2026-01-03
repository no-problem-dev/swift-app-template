import APIContract
import Foundation

/// Errors for Categories API
public enum CategoriesAPIError: APIContractError {
    case notFound(categoryId: String)
    case invalidInput(message: String)
    case categoryInUse(categoryId: String)
    case unauthorized
    case serverError(message: String)

    // MARK: - APIContractError

    public var statusCode: Int {
        switch self {
        case .notFound:
            return 404
        case .invalidInput:
            return 400
        case .categoryInUse:
            return 409
        case .unauthorized:
            return 401
        case .serverError:
            return 500
        }
    }

    public var errorCode: String {
        switch self {
        case .notFound:
            return "CATEGORY_NOT_FOUND"
        case .invalidInput:
            return "INVALID_INPUT"
        case .categoryInUse:
            return "CATEGORY_IN_USE"
        case .unauthorized:
            return "UNAUTHORIZED"
        case .serverError:
            return "SERVER_ERROR"
        }
    }

    public var message: String {
        switch self {
        case .notFound(let categoryId):
            return "Category not found: \(categoryId)"
        case .invalidInput(let message):
            return "Invalid input: \(message)"
        case .categoryInUse(let categoryId):
            return "Category is in use and cannot be deleted: \(categoryId)"
        case .unauthorized:
            return "Unauthorized access"
        case .serverError(let message):
            return "Server error: \(message)"
        }
    }
}
