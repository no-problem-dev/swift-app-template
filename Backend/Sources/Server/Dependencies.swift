import APIServer
import BackendServices
import FirebaseAuthServer
import Shared

struct Dependencies: Sendable {
    let authClient: AuthClient
    let services: AppServices

    static func resolve(logger: ServerLogger) async throws -> Dependencies {
        let appConfig = AppConfig.load()

        let authClient = AuthClientFactory.create(config: appConfig)
        let firestoreClient = try await FirestoreClientFactory.create(config: appConfig)
        let schema = TodoAppSchema(client: firestoreClient)

        let todoRepository = TodoRepositoryImpl(schema: schema)
        let categoryRepository = CategoryRepositoryImpl(schema: schema)
        let profileRepository = ProfileRepositoryImpl(schema: schema)

        let todoUseCase = TodoUseCase(todoRepository: todoRepository)
        let categoryUseCase = CategoryUseCase(categoryRepository: categoryRepository)
        let profileUseCase = ProfileUseCase(profileRepository: profileRepository)

        let services = AppServices(
            auth: AuthService(),
            profile: ProfileAPIServiceImpl(profileUseCase: profileUseCase),
            todos: TodosService(todoUseCase: todoUseCase),
            categories: CategoriesService(categoryUseCase: categoryUseCase)
        )

        if appConfig.gcp.useEmulator {
            logger.info("🔧 Using Firebase Emulator")
        } else {
            logger.info("🔥 Using Production Firebase")
        }

        return Dependencies(authClient: authClient, services: services)
    }
}
