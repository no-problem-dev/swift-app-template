import APIContract
import Foundation

/// Errors for Todos API
public enum TodosAPIError: APIContractError {
    case notFound(todoId: String)
    case invalidInput(message: String)
    case unauthorized
    case serverError(message: String)

    // MARK: - APIContractError

    public var statusCode: Int {
        switch self {
        case .notFound:
            return 404
        case .invalidInput:
            return 400
        case .unauthorized:
            return 401
        case .serverError:
            return 500
        }
    }

    public var errorCode: String {
        switch self {
        case .notFound:
            return "TODO_NOT_FOUND"
        case .invalidInput:
            return "INVALID_INPUT"
        case .unauthorized:
            return "UNAUTHORIZED"
        case .serverError:
            return "SERVER_ERROR"
        }
    }

    public var message: String {
        switch self {
        case .notFound(let todoId):
            return "Todo not found: \(todoId)"
        case .invalidInput(let message):
            return "Invalid input: \(message)"
        case .unauthorized:
            return "Unauthorized access"
        case .serverError(let message):
            return "Server error: \(message)"
        }
    }
}
