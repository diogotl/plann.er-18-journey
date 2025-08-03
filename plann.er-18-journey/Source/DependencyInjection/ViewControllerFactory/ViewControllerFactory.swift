//
//  ViewControllerFactory.swift
//  plann.er-18-journey
//
//  Created by Diogo on 06/03/2025.
//

import Foundation
import CoreData

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    func makeActivityListViewController() -> ActivityListViewController {
        
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        
        let view = ActivityListView()
        let viewModel = ActivityListViewModel(
            context: managedObjectContext
        )
        let viewController = ActivityListViewController(
            contentView: view,
            viewModel: viewModel
        )
        return viewController
    }
    
    func makeInvitationViewController() -> InvitationViewController {
        let view = InvitationView()
        let viewModel = InvitationViewModel()
        let viewController = InvitationViewController(
            contentView: view,
            viewModel: viewModel
        )
        return viewController
    }
    
    func makeHomeViewController(coordinatorDelegate: HomeCoordinatorDelegate) -> HomeViewController {
        let view = HomeView()
        let viewModel = InvitationViewModel()
        let viewController = HomeViewController(
            contentView: view,
            coordinatorDelegate: coordinatorDelegate,
            invitationViewModel: viewModel
        )
        return viewController
    }
}
