//
//  Coordinator.swift
//  plann.er-18-journey
//
//  Created by Diogo on 06/03/2025.
//

import Foundation
import UIKit

class Coordinator {
    // MARK -> Props
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    public init() {
        self.viewControllerFactory = ViewControllerFactory()
    }
    
    func start() -> UINavigationController? {
        let startViewController = viewControllerFactory.makeHomeViewController(
            coordinatorDelegate: self
        )
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

extension Coordinator: HomeCoordinatorDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheet = viewControllerFactory.makeInvitationViewController()
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        navigationController?.present(loginBottomSheet, animated: true, completion: nil)
        
    }
    
    func navigateToActivityList() {
        let activityListViewController = viewControllerFactory.makeActivityListViewController()
        navigationController?.pushViewController(activityListViewController, animated: true)
    }
}

