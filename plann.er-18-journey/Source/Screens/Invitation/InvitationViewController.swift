//
//  InvitationViewController.swift
//  plann.er-18-journey
//
//  Created by Diogo on 07/03/2025.
//

import Foundation
import UIKit

class InvitationViewController: UIViewController {
    
    let contentView: InvitationView
    let viewModel: InvitationViewModel
    
    public init (
        contentView: InvitationView,
        viewModel: InvitationViewModel
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.contentView.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(contentView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension InvitationViewController: InvitationViewDelegate {
    func didTapDismissButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
