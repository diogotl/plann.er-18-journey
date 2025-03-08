import Foundation
import UIKit

class InvitationView: UIView {
    
    //var items: [String] = []
    var viewModel: InvitationViewModel!
    weak var delegate: InvitationViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let blurredBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.zinc900
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Invite your friends"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "The invitation will be sent by email to the selected contacts"
        label.textColor = Colors.zinc400
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = Colors.zinc400
        button.backgroundColor = .clear
        button.setTitleColor(Colors.lime950, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = Colors.zinc400.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    func didTapDismissButton() {
        delegate?.didTapDismissButton()
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.zinc900
        tableView.separatorStyle = .none
        tableView.register(InvitationCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.zinc800
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inviteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Invite", for: .normal)
        button.backgroundColor = Colors.lime300
        button.setTitleColor(Colors.lime950, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.zinc800.cgColor
        return button
    }()
    
    let inputField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter a friend's name", attributes: [NSAttributedString.Key.foregroundColor: Colors.zinc400])
        textField.placeholder = "Enter a friend's name"
        textField.backgroundColor = Colors.zinc950
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private func setupUI() {
        self.addSubview(blurredBackgroundView)
        self.addSubview(view)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(dismissButton)
        view.addSubview(tableView)
        view.addSubview(divider)
        view.addSubview(inviteButton)
        view.addSubview(inputField)
        
        setupConstraints()
        
        inviteButton.addTarget(self, action: #selector(inviteButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blurredBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurredBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurredBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            blurredBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            dismissButton.widthAnchor.constraint(equalToConstant: 32),
            dismissButton.heightAnchor.constraint(equalToConstant: 32),
            
            divider.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            inviteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inviteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            inviteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            inviteButton.heightAnchor.constraint(equalToConstant: 42),
            
            inputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            inputField.bottomAnchor.constraint(equalTo: inviteButton.topAnchor, constant: -16),
            inputField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputField.topAnchor, constant: -16)
        ])
    }
    
    @objc
    func inviteButtonTapped() {
        if let newItem = inputField.text, !newItem.isEmpty {
            let guest = Guest(email:newItem)
            viewModel.addItem(guest)
            tableView.reloadData()
            inputField.text = ""
        }
    }
}

extension InvitationView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InvitationCell
        cell.itemLabel.text = viewModel.item(at: indexPath.row).email
        cell.removeButtonAction = { [weak self] in
            self?.viewModel.removeItem(at: indexPath.row)
            self?.tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.guestsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

class InvitationCell: UITableViewCell {
    
    var removeButtonAction: (() -> Void)?
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.zinc400
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitleColor(Colors.zinc800, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = Colors.zinc400
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.zinc800
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(itemLabel)
        contentView.addSubview(removeButton)
        
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            removeButton.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 16),
            removeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func removeButtonTapped() {
        removeButtonAction?()
    }
}
