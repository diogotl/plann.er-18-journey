import Foundation
import UIKit
import FSCalendar

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    private var selectedStartDate: Date?
    private var selectedEndDate: Date?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "plann.er"
        label.textColor = .white
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Invite your friends to join your journey"
        label.textColor = Colors.zinc400
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.zinc900
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3).cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let locationInput: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Localização",
            attributes: [
                NSAttributedString.Key.foregroundColor: Colors.zinc400,
            ]
        )
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.backgroundColor = Colors.zinc900
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView(image: UIImage(systemName: "location.fill"))
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = Colors.zinc400
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            containerView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    
    let dateInput: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Selecione as datas",
            attributes: [
                NSAttributedString.Key.foregroundColor: Colors.zinc400,
            ]
        )
        
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.backgroundColor = Colors.zinc900
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView(image: UIImage(systemName: "calendar"))
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = Colors.zinc400
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            containerView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = Colors.lime950
        button.setTitleColor(Colors.lime950, for: .normal)
        button.setTitle("Continuar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = Colors.lime300
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.semanticContentAttribute = .forceRightToLeft
        
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func didTapContinueButton() {
        
        if let location = locationInput.text, !location.isEmpty,
           let startDate = selectedStartDate,
           let endDate = selectedEndDate {
            
            // Se todos os campos forem válidos, desabilita os campos de input e alterna a visibilidade dos botões
            locationInput.isEnabled = false
            dateInput.isEnabled = false
            
            editButton.isHidden = !editButton.isHidden
            inviteButton.isHidden = !inviteButton.isHidden
            
            errorLabel.isHidden = true
            locationInput.textColor = Colors.zinc400
            dateInput.textColor = Colors.zinc400
            
            divider.isHidden = false
            
        } else {
            errorLabel.text = "Preenche todos os campos"
            errorLabel.isHidden = false
        }
    }
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Alterar local/data", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.backgroundColor = Colors.zinc800
        button.tintColor = Colors.zinc200
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.semanticContentAttribute = .forceRightToLeft
        button.isHidden = true
        
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func editButtonTapped() {
        locationInput.isEnabled = true
        dateInput.isEnabled = true
        editButton.isHidden = !editButton.isHidden
        inviteButton.isHidden = !inviteButton.isHidden
        locationInput.textColor = .white
        dateInput.textColor = .white
    }
    
    let divider:UIView = {
        let view = UIView()
        view.backgroundColor = Colors.zinc800
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inviteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Quem estará na viagem?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        
        button.addTarget(self, action: #selector(inviteButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    @objc
    private func inviteButtonTapped() {
        
        let location = locationInput.text
        let startDate = selectedStartDate
        let endDate = selectedEndDate
        
        print(location, startDate, endDate)
        
        delegate?.didTapInviteButton()
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(showCalendarModal)
        )
        dateInput.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func showCalendarModal() {
        guard let viewController = self.window?.rootViewController else {
            return
        }
        
        let calendarVC = CalendarViewController()
        calendarVC.modalPresentationStyle = .overCurrentContext
        calendarVC.modalTransitionStyle = .crossDissolve
        
        calendarVC.dateSelectionHandler = { [weak self] startDate, endDate in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            self?.selectedStartDate = startDate
            self?.selectedEndDate = endDate
            
            self?.dateInput.text = "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
        }
        
        viewController.present(calendarVC, animated: true, completion: nil)
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(containerView)
        
        containerView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(locationInput)
        contentStackView.addArrangedSubview(dateInput)
        contentStackView.addArrangedSubview(editButton)
        contentStackView.addArrangedSubview(divider)
        contentStackView.addArrangedSubview(inviteButton)
        contentStackView.addArrangedSubview(continueButton)
        
        addSubview(errorLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            errorLabel.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 32),
            errorLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            
            locationInput.heightAnchor.constraint(equalToConstant: 44),
            dateInput.heightAnchor.constraint(equalToConstant: 44),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            editButton.heightAnchor.constraint(equalToConstant: 44),
            inviteButton.heightAnchor.constraint(equalToConstant: 44),
            
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
