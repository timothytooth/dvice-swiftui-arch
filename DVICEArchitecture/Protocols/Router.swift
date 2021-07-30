import Foundation

enum AppPage {
    case home
    case favorites
    case account
    case cart
}

protocol Router: AnyObject {
    func canRoute(to page: AppPage) -> Bool
    func route(to page: AppPage)
}

extension Router {
    func canRoute(to page: AppPage) -> Bool { return false }
    func route(to page: AppPage) { assertionFailure("Must be implemented") }
}
