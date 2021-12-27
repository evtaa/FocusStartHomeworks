//
//  AuthView.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import Foundation

import UIKit

protocol IAuthView: UIView {
    var rootViewTapGestureRecognizerHandler: (() -> Void)? { get set }
    var authorizationButtonTouchUpInsideHandler: (() -> Void)? { get set }
    var registrationButtonTouchUpInsideHandler: (() -> Void)? { get set }
    var doneButtonActionHandler: (() -> Void)? { get set }
    
    func setTextFieldDelegate (object: UITextFieldDelegate)
    func endEditingView()
    func getUsername() -> String? 
    func getPassword() -> String?
}

final class AuthView: UIView {
    
    //MARK: - Handlers
    var rootViewTapGestureRecognizerHandler: (() -> Void)?
    var authorizationButtonTouchUpInsideHandler: (() -> Void)?
    var registrationButtonTouchUpInsideHandler: (() -> Void)?
    var doneButtonActionHandler: (() -> Void)?
    
    // MARK: Subviews
    private lazy var tapRootView: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.cancelsTouchesInView = false
        recognizer.addTarget(self, action: #selector(rootViewTapGestureRecognizer))
        return recognizer
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    } ()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tittleLabel,
                                                       usernameTextField,
                                                       passwordTextField,
                                                       authorizationButton,
                                                       registrationButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.Auth.spacingMainStackView
        stackView.setCustomSpacing(AppLayout.Auth.customSpacingAfterTitleLabel,
                                   after: tittleLabel)
        return stackView
    }()
    
    private let tittleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = AppText.Auth.title
        label.font = AppFont.bigSystemBold
        label.textAlignment = .center
        return label
    }()
    
    private lazy var doneToolBar: UIToolbar = {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0,
                                                                  y: 0,
                                                                  width: AppLayout.widthScreen,
                                                                  height: AppLayout.Auth.heightDoneButton))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: AppText.done,
                                                    style: .done,
                                                    target: self,
                                                    action: #selector(doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        return doneToolbar
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.setAuthTextField()
        textField.placeholder = AppText.Auth.enterUsername
        textField.inputAccessoryView = self.doneToolBar
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setAuthTextField()
        textField.placeholder = AppText.Auth.enterPassword
        textField.isSecureTextEntry = true
        textField.inputAccessoryView = self.doneToolBar
        return textField
    }()
    
    private lazy var authorizationButton: UIButton = {
        let button = UIButton()
        button.setAuthButton()
        button.setTitle(AppText.Auth.authorization, for: .normal)
        button.addTarget(self, action: #selector(authorizationButtonTouchUpInside),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setAuthButton()
        button.setTitle(AppText.Auth.registration, for: .normal)
        button.addTarget(self, action: #selector(registrationButtonTouchUpInside),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainStackView()
        configureLayoutView()
        configureGestureRecognizer()
        backgroundColor = AppColors.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    @objc private func authorizationButtonTouchUpInside() {
        authorizationButtonTouchUpInsideHandler?()
    }
    
    @objc private func registrationButtonTouchUpInside() {
        registrationButtonTouchUpInsideHandler?()
    }
    
    @objc private func doneButtonAction() {
        doneButtonActionHandler?()
    }
    
    @objc private func rootViewTapGestureRecognizer() {
        rootViewTapGestureRecognizerHandler?()
    }
    
    // MARK: - Configure
    private func configureGestureRecognizer() {
        addGestureRecognizer(tapRootView)
    }
    
    private func configureMainStackView() {
        let scrollArea = self.scrollView.contentLayoutGuide
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(equalToConstant: AppLayout.Auth.heightTextField),
            passwordTextField.heightAnchor.constraint(equalToConstant: AppLayout.Auth.heightTextField),
            authorizationButton.heightAnchor.constraint(equalToConstant: AppLayout.Auth.heightButton),
            registrationButton.heightAnchor.constraint(equalToConstant: AppLayout.Auth.heightButton),

            mainStackView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
                                               constant: AppLayout.Auth.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                                   constant: AppLayout.Auth.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
                                                    constant: AppLayout.Auth.trailingMainStackView)
        ])
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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

// MARK: - IAuthView
extension AuthView: IAuthView {
    func setTextFieldDelegate (object: UITextFieldDelegate) {
        usernameTextField.delegate = object
        passwordTextField.delegate = object
    }
    
    func endEditingView() {
        endEditing(true)
    }
    
    func getUsername() -> String? {
        return usernameTextField.text
    }
    
    func getPassword() -> String? {
        return passwordTextField.text
    }
}
