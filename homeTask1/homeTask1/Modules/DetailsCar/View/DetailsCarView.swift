//
//  DetailsCarView.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 28.10.2021.
//

import UIKit

class DetailsCarView: UIView {
    // MARK: - Subviews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
                                        manufacturerLabel, manufacturerTextField,
                                        modelLabel, modelTextField,
                                        bodyLabel, bodyTextField,
                                        yearOfIssueLabel,yearOfIssueTextField,
                                        carNumberLabel, carNumberTextField ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let manufacturerLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = "The manufacturer is"
        return label
    } ()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = "The model is"
        return label
    } ()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = "The body is"
        return label
    } ()
    
    private let yearOfIssueLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = "The year of issue is"
        return label
    } ()
    
    private let carNumberLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = "The car number is"
        return label
    } ()
    
     let manufacturerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the car manufacturer"
        textField.setForParametersOfCar()
        return textField
    }()
    
    let modelTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the car model"
        textField.setForParametersOfCar()
        return textField
    }()
    
    let bodyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the car body"
        textField.setForParametersOfCar()
        return textField
    }()
    
    let yearOfIssueTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the car year of issue"
        textField.setForParametersOfCar()
        return textField
    }()
    
    let carNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the car number"
        textField.setForParametersOfCar()
        return textField
    }()
    
    private(set) var bodyPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        return pickerView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    private func configureUI() {
        backgroundColor = .white
        configureLabelsForMainStackView()
        configureTextFieldsForMainStackView()
        configureMainStackView()
    }
    
    private func configureLabelsForMainStackView() {
        let height = AppLayout.DetailsCar.heightOfParameterOfCarLabel
        NSLayoutConstraint.activate([
            manufacturerLabel.heightAnchor.constraint(equalToConstant: height),
            modelLabel.heightAnchor.constraint(equalToConstant: height),
            bodyLabel.heightAnchor.constraint(equalToConstant: height),
            yearOfIssueLabel.heightAnchor.constraint(equalToConstant: height),
            carNumberLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureTextFieldsForMainStackView() {
        let height = AppLayout.DetailsCar.heightOfParameterOfCarTextField
        NSLayoutConstraint.activate([
            manufacturerTextField.heightAnchor.constraint(equalToConstant: height),
            modelTextField.heightAnchor.constraint(equalToConstant: height),
            bodyTextField.heightAnchor.constraint(equalToConstant: height),
            yearOfIssueTextField.heightAnchor.constraint(equalToConstant: height),
            carNumberTextField.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureMainStackView() {
        addSubview(mainStackView)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: AppLayout.DetailsCar.topStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.DetailsCar.leadingStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.ListCars.trailingStackView)
        ])
    }
    
}
