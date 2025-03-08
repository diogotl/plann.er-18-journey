//
//  HomeViewController.swift
//  plann.er-18-journey
//
//  Created by Diogo on 04/03/2025.
//
import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let contentView: HomeView
    let coordinatorDelegate: HomeCoordinatorDelegate?
    let invitationViewModel: InvitationViewModel
    
    public init (
        contentView: HomeView,
        coordinatorDelegate: HomeCoordinatorDelegate,
        invitationViewModel: InvitationViewModel
    ) {
        self.contentView = HomeView()
        self.coordinatorDelegate = coordinatorDelegate
        self.invitationViewModel = invitationViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.zinc950
        contentView.delegate = self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }


func updateInviteButtonText() {
    let count = invitationViewModel.guestsCount
    
    if count > 0 {
        // Se houver convidados, mostre quantos
        let text = count == 1 ? 
            "1 pessoa estará na viagem" : 
            "\(count) pessoas estarão na viagem"
        
        contentView.inviteButton.setTitle(text, for: .normal)
    } else {
        contentView.inviteButton.setTitle("Quem estará na viagem?", for: .normal)
    }
}
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapContinueButton() {
        // Navigate to the next screen
    }
    
    func didTapInviteButton() {
        //chegou aqui
        coordinatorDelegate?.openLoginBottomSheet()
    }
}

extension HomeViewController: HomeCoordinatorDelegate {
    func navigateToActivityList() {
        /// Navigate to the next screen
    }
    
    func openLoginBottomSheet() {
        // Navigate to the next screen
        print("nao estou a perceber")
        
    }
    
}
