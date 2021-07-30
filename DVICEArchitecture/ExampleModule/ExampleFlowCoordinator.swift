import Foundation
import Combine
import UIKit

class ExampleFlowCoordinator: ParentFlowCoordinator, Navigable {
    weak var parentCoordinator: ParentFlowCoordinator?
    var activeChildCoordinators: [FlowCoordinator] = []
    
    private let navigationSubject = PassthroughSubject<NavigationDirection, Never>()
    var navigationPublisher: AnyPublisher<NavigationDirection, Never> {
        navigationSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private var presenter: Presenter?
    private var director: ExampleDirector?

    init(parentCoordinator: ParentFlowCoordinator?) {
        self.parentCoordinator = parentCoordinator
    }
    
    func beginFlow(presenter: Presenter) {
        self.presenter = presenter
        parentCoordinator?.childFlowBegan(self)
        
        let interactor = WPExampleInteractor()
        
        let director = ExampleDirector(interactor: interactor)
        director.segueNextModule = segueNextModule
        director.closeModule = closeModule
        
        self.director = director
        
        let view = ExampleView(director: director, navigationPublisher: navigationPublisher)
//        navigationSubject.send(.forward(destination: .example, style: .push))
        
        presenter.present(view)
    }
    
    func endFlow() {
        director = nil
        parentCoordinator?.childFlowEnded(self)
    }
    
    private lazy var segueNextModule: () -> Void = { [weak self] in
        guard let self = self, let presenter = self.presenter else { return }
        
        let anotherFlowCoordinator = ExampleFlowCoordinator(parentCoordinator: self)
        anotherFlowCoordinator.beginFlow(presenter: presenter)
    }
    
    private lazy var closeModule: () -> Void = { [weak self] in
        guard let self = self else { return }
        
//        self.navigationSubject.send(.back)
        self.endFlow()
    }
}
