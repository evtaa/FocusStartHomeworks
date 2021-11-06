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
    
    private(set) var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    } ()
    
    private let manufacturerLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = Text.manufacturerIs
        return label
    } ()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = Text.modelIs
        return label
    } ()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = Text.bodyIs
        return label
    } ()
    
    private let yearOfIssueLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = Text.yearOfIssueIs
        return label
    } ()
    
    private let carNumberLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        label.text = Text.carNumberIs
        return label
    } ()
    
     let manufacturerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Text.manufacturerEnter
        textField.setForParametersOfCar()
        return textField
    }()
    
    let modelTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Text.modelEnter
        textField.setForParametersOfCar()
        return textField
    }()
    
    let bodyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Text.bodyEnter
        textField.setForParametersOfCar()
        return textField
    }()
    
    let yearOfIssueTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = Text.yearOfIssueEnter
        textField.setForParametersOfCar()
        return textField
    }()
    
    let carNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Text.carNumberEnter
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
        configureScrollView()
        configureTextFieldsForMainStackView()
        configureMainStackView()
    }
    
    private func configureScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor)
        ])
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
        let scrollArea = self.scrollView.contentLayoutGuide
        scrollView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
                                               constant: AppLayout.DetailsCar.topStackView),
            mainStackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                               constant: AppLayout.DetailsCar.leadingStackView),
            mainStackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
                                                constant: AppLayout.ListCars.trailingStackView)
        ])
    }
    
}
