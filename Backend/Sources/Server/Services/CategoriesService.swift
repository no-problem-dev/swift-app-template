import APIServer
import BackendServices
import Shared

struct CategoriesService: CategoriesAPIService {
    private let categoryUseCase: CategoryUseCase

    init(categoryUseCase: CategoryUseCase) {
        self.categoryUseCase = categoryUseCase
    }

    func handle(_ input: CategoriesAPI.List, context: ServiceContext) async throws -> [TodoCategory] {
        let userId = try context.requireUserId()
        return try await categoryUseCase.getCategories(userId: userId)
    }

    func handle(_ input: CategoriesAPI.Get, context: ServiceContext) async throws -> TodoCategory {
        let userId = try context.requireUserId()
        guard let category = try await categoryUseCase.getCategory(userId: userId, categoryId: input.categoryId) else {
            throw CategoriesAPIError.notFound(categoryId: input.categoryId)
        }
        return category
    }

    func handle(_ input: CategoriesAPI.Create, context: ServiceContext) async throws -> TodoCategory {
        let userId = try context.requireUserId()
        return try await categoryUseCase.createCategory(userId: userId, input: input.input)
    }

    func handle(_ input: CategoriesAPI.Update, context: ServiceContext) async throws -> TodoCategory {
        let userId = try context.requireUserId()
        return try await categoryUseCase.updateCategory(userId: userId, categoryId: input.categoryId, input: input.input)
    }

    func handle(_ input: CategoriesAPI.Delete, context: ServiceContext) async throws -> EmptyResponse {
        let userId = try context.requireUserId()
        try await categoryUseCase.deleteCategory(userId: userId, categoryId: input.categoryId)
        return EmptyResponse()
    }
}
