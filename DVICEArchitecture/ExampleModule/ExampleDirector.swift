import Foundation
import Combine

class ExampleDirector: ExampleDirectorInterface, ObservableObject {
    var segueNextModule: (() -> Void)?
    var closeModule: (() -> Void)?
    
    private let translator: ExampleViewTranslator = .init()
    private let interactor: ExampleInteractor
    private var cancellables: [AnyCancellable] = []
    
    @Published var viewModel: ExampleViewModel = .init()
    
    init(interactor: ExampleInteractor) {
        self.interactor = interactor
    }
    
    func handleAction(_ action: ExampleAction) {
        switch action {
        case .mainButtonTapped:
            segueNextModule?()
        case .secondaryButtonTapped:
            interactor.getData()
                .sink {
                    // Do something with the data
                    self.viewModel = self.translator.transformError(viewModel: self.viewModel)
                }
                .store(in: &cancellables)
        case .closeButtonTapped:
            closeModule?()
        }
    }
}
