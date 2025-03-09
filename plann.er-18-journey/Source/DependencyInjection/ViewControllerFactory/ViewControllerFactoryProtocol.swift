//
//  V.swift
//  plann.er-18-journey
//
//  Created by Diogo on 06/03/2025.
//
import Foundation

protocol ViewControllerFactoryProtocol: AnyObject {
    func makeHomeViewController(coordinatorDelegate: HomeCoordinatorDelegate) -> HomeViewController
    func makeInvitationViewController() -> InvitationViewController
    func makeActivityListViewController() -> ActivityListViewController
}
