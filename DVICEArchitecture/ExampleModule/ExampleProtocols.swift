import Foundation

enum ExampleAction {
    case mainButtonTapped
    case secondaryButtonTapped
    case closeButtonTapped
}

protocol ExampleDirectorInterface {
    func handleAction(_ action: ExampleAction)
}

struct ExampleViewModel {
    var isAlertShowing: Bool = false
    var errorString: String = ""
}
