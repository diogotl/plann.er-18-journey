import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var dateSelectionHandler: ((Date, Date) -> Void)?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.zinc900.withAlphaComponent(0.9)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.allowsMultipleSelection = true
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.weekdayTextColor = Colors.zinc400
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = Colors.zinc400
        calendar.backgroundColor = .clear
        calendar.appearance.selectionColor = Colors.lime300.withAlphaComponent(0.5)
        calendar.appearance.todayColor = Colors.lime300.withAlphaComponent(0.3)
        return calendar
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirmar", for: .normal)
        button.backgroundColor = Colors.lime300
        button.setTitleColor(Colors.lime950, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione o Período"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var startDate: Date?
    private var endDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupCalendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBlurBackground()
    }
    
    private func setupBlurBackground() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurView, at: 0)
    }
    
    private func setupView() {
        view.backgroundColor = .clear
        view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(calendar)
        containerView.addSubview(confirmButton)
        containerView.addSubview(errorLabel)
        
        confirmButton.addTarget(self, action: #selector(confirmDateSelection), for: .touchUpInside)
    }
    
    private func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = true
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 340),
            containerView.heightAnchor.constraint(equalToConstant: 550),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            calendar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            calendar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalToConstant: 300),
            
            errorLabel.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            confirmButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10),
            confirmButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            confirmButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return date >= Date().startOfDay
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        clearError()
        
        if startDate == nil {
            startDate = date
        } else if endDate == nil {
            if date > startDate! {
                endDate = date
                validateDateRange()
            } else {
                startDate = date
                endDate = nil
            }
        } else {
            startDate = date
            endDate = nil
        }
        
        calendar.reloadData()
    }
    
    private func validateDateRange() {
        guard let start = startDate, let end = endDate else { return }
        
        // Validações de intervalo de datas
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        if let days = components.day, days > 30 {
            showError("Intervalo máximo de 30 dias")
            endDate = nil
        }
    }
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        
        // Opcional: Animar a aparição do erro
        UIView.animate(withDuration: 0.3) {
            self.errorLabel.alpha = 1.0
        }
    }
    
    private func clearError() {
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        guard let start = startDate, let end = endDate else { return nil }
        
        if date >= start && date <= end {
            return Colors.lime300.withAlphaComponent(0.3)
        }
        
        return nil
    }
    
    @objc private func confirmDateSelection() {
        guard let start = startDate, let end = endDate else {
            showError("Por favor, selecione um intervalo de datas")
            return
        }
        
        // Validações finais
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        if let days = components.day {
            if days > 30 {
                showError("Intervalo máximo de 30 dias")
                return
            }
        }
        
        dateSelectionHandler?(start, end)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 20).cgPath
    }
}

// Extensão para obter o início do dia
extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
