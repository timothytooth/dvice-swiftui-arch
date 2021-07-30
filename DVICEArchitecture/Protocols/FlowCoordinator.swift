import Foundation

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: ParentFlowCoordinator? { get set }
    func endFlow()
}

extension FlowCoordinator {
    func endFlow() {
        assertionFailure("endFlow must be implemented")
    }
}

protocol ParentFlowCoordinator: FlowCoordinator {
    var activeChildCoordinators: [FlowCoordinator] { get set }
    
    func childFlowBegan(_ childFlowCoordinator: FlowCoordinator)
    func childFlowEnded(_ childFlowCoordinator: FlowCoordinator)
}

extension ParentFlowCoordinator {
    func childFlowBegan(_ childFlowCoordinator: FlowCoordinator) {
        activeChildCoordinators.append(childFlowCoordinator)
    }
    
    func childFlowEnded(_ childFlowCoordinator: FlowCoordinator) {
        activeChildCoordinators.removeAll { $0 === childFlowCoordinator }
    }
}

