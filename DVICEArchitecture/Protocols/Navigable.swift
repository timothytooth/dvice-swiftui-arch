import Foundation
import Combine

enum NavigationDirection {
    case back
    case forward(destination: NavigationDestination, style: NavigationStyle)
}

enum NavigationDestination {
    case example
}

enum NavigationStyle {
    case push
    case present
}

protocol Navigable {
    var navigationPublisher: AnyPublisher<NavigationDirection, Never> { get }
}
