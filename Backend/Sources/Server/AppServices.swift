import APIContract
import APIServer
import BackendServices
import Shared

@APIServices
public struct AppServices: Sendable {
    let auth: AuthService
    let profile: ProfileAPIServiceImpl
    let todos: TodosService
    let categories: CategoriesService
}
