//
//  EditEmployeeView.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import UIKit

protocol IEditEmployeeView: UIView {
    func configure (with model: IEmployeeViewModel)
    func getNameOfEmployee() -> String?
    func getAgeOfEmployee() -> String?
    func getExperienceOfEmployee() -> String?
}

final class EditEmployeeView: UIView {
    // MARK: - Subviews
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    } ()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField,
                                                       ageLabel, ageTextField,
                                                       experienceLabel, experienceTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.EditEmployee.spacingMainStackView
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = AppText.enterNameEmployee
        return label
    } ()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AppText.enterNameEmployee
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = AppText.enterAgeEmployee
        return label
    } ()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AppText.enterAgeEmployee
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let experienceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = AppText.enterExperienceEmployee
        return label
    } ()
    
    private let experienceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AppText.enterExperienceEmployee
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = .numberPad
        return textField
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainStackView()
        configureLayoutView()
        backgroundColor = AppColors.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configureMainStackView() {
        let scrollArea = self.scrollView.contentLayoutGuide
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
                                               constant: AppLayout.EditEmployee.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                                   constant: AppLayout.EditEmployee.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
                                                    constant: AppLayout.EditEmployee.trailingMainStackView)
        ])
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - IEditEmployeeView
extension EditEmployeeView: IEditEmployeeView {
    func configure (with model: IEmployeeViewModel) {
        nameTextField.text = model.name
        ageTextField.text = model.age
        experienceTextField.text = model.experience
    }
    
    func getNameOfEmployee() -> String? {
      return  nameTextField.text
    }
    
    func getAgeOfEmployee() -> String? {
      return  ageTextField.text
    }
    
    func getExperienceOfEmployee() -> String? {
      return  experienceTextField.text
    }
}
