//
//  NavigationPresenter.swift
//  DVICEArchitecture
//
//  Created by Timothy Esposito on 7/28/21.
//

import Foundation
import UIKit
import SwiftUI

class NavigationPresenter: NSObject, Presenter {
    private weak var navigationController: UINavigationController?
    private let dismissCompletion: (() -> Void)?
    private let popToRootBlock: (() -> Void)?
    
    init(navigationController: UINavigationController, dismissCompletion: (() -> Void)? = nil, popToRootBlock: (() -> Void)? = nil) {
        self.navigationController = navigationController
        self.dismissCompletion = dismissCompletion
        self.popToRootBlock = popToRootBlock
    }
    
    init(navigationPresenter: NavigationPresenter, dismissCompletion: (() -> Void)? = nil, popToRootBlock: (() -> Void)? = nil) {
        self.navigationController = navigationPresenter.navigationController
        self.dismissCompletion = dismissCompletion
        self.popToRootBlock = popToRootBlock
    }
    
    func present<ContentView: View>(_ view: ContentView) {
        guard let navigationController = navigationController else { return }
        
        let hostingController = UIHostingController(rootView: view)
        
        if navigationController.viewControllers.isEmpty {
            navigationController.viewControllers = [hostingController]
        } else {
            navigationController.pushViewController(hostingController, animated: true)
        }
    }
    
    func dismiss(completion: (() -> Void)? = nil) {
        completion?()
        dismissCompletion?()
    }
    
    func popToRoot() {
        popToRootBlock?()
    }
}

extension UINavigationController {
    var navigationPresenter: Presenter {
        return NavigationPresenter(navigationController: self)
    }
}
