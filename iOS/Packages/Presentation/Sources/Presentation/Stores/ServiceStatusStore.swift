import SwiftUI

/// サービス状態を管理
@MainActor @Observable
public final class ServiceStatusStore {
    public enum Status: Sendable {
        case normal
        case maintenance
        case unauthorized
    }

    public private(set) var status: Status = .normal

    nonisolated public init() {}

    public func setMaintenance() { status = .maintenance }
    public func setUnauthorized() { status = .unauthorized }
    public func reset() { status = .normal }
}

extension EnvironmentValues {
    @Entry public var serviceStatusStore: ServiceStatusStore = .init()
}
