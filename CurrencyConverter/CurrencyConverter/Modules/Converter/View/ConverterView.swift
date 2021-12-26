//
//  ConverterView.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IConverterView: UIView {
    
    var replaceButtonTouchUpInsideHandler: (() -> Void)? { get set }
    var doneButtonActionHandler: (() -> Void)? { get set }
    var copyToBufferButtonTouchUpInsideHandler: (() -> Void)? { get set }
    var rootViewTapGestureRecognizerHandler: (() -> Void)? { get set }
    var currencyInputTextFieldEditingChangedHandler: (() -> Void)? { get set }
    
    func configure(with model: IConvertorViewModel)
    func endEditingView()
    func setPickerViewDelegate(object: UIPickerViewDataSource & UIPickerViewDelegate)
    func setTextFieldDelegate (object: UITextFieldDelegate)
    func isEditingTypeOfCurrencyInputTextField () -> Bool
    func isEditingTypeOfCurrencyOutputTextField () -> Bool
    func getTextCurrencyInputTextField() -> String?
    func selectRowForPickerViewInput(row: Int)
    func selectRowForPickerViewOutput(row: Int)
    func setScrollEnabled(enabled: Bool)
    func setScrollContentInset(contentInsets: UIEdgeInsets)
    func setScrollIndicatorInsets(contentInsets: UIEdgeInsets)
    func getCurrencyOutputTextField() -> UITextField
    func scrollRectToVisible(rect: CGRect)
}

final class ConverterView: UIView {
    
    //MARK: - Handlers
    var replaceButtonTouchUpInsideHandler: (() -> Void)?
    var doneButtonActionHandler: (() -> Void)?
    var copyToBufferButtonTouchUpInsideHandler: (() -> Void)?
    var rootViewTapGestureRecognizerHandler: (() -> Void)?
    var currencyInputTextFieldEditingChangedHandler: (() -> Void)?
    
    // MARK: - Subviews
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
        let stackView = UIStackView(arrangedSubviews: [dateLabel,
                                                       nameOfCurrencyInputLabel,
                                                       currencyInputStackView,
                                                       replaceButton,
                                                       nameOfCurrencyOutputLabel,
                                                       currencyOutputStackView,
                                                       copyToBufferButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = AppLayout.Converter.spacingMainStackView
        stackView.setCustomSpacing(AppLayout.Converter.customSpacingAfterDateLabel,
                                   after: dateLabel)
        stackView.setCustomSpacing(AppLayout.Converter.customSpacingAfterNameOfCurrencyLabel,
                                   after: nameOfCurrencyInputLabel)
        stackView.setCustomSpacing(AppLayout.Converter.customSpacingAfterNameOfCurrencyLabel,
                                   after: nameOfCurrencyOutputLabel)
        stackView.setCustomSpacing(AppLayout.Converter.customSpacingAfterCurrencyOutputStackView,
                                   after: currencyOutputStackView)
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.Auth.dateLabelTextNormalColor
        label.font = AppFont.smallSystem
        return label
    }()
    
    private let nameOfCurrencyInputLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppFont.smallSystemBold
        return label
    }()
    
    private let nameOfCurrencyOutputLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppFont.smallSystemBold
        return label
    }()
    
    private lazy var currencyInputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [typeOfCurrencyInputTextField,
                                                       currencyInputTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = AppLayout.Converter.spacingTypeOfCurrencyStackView
        return stackView
    }()
    
    private lazy var doneToolBar: UIToolbar = {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0,
                                                                  y: 0,
                                                                  width: AppLayout.widthScreen,
                                                                  height: AppLayout.Converter.heightDoneButton))
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
    
    private lazy var typeOfCurrencyInputTextField: UITextField = {
        let textField = UITextField()
        textField.setTypeOfCurrency()
        textField.inputView = typeOfCurrencyInputPickerView
        textField.inputAccessoryView = self.doneToolBar
        return textField
    }()
    
    private lazy var typeOfCurrencyOutputTextField: UITextField = {
        let textField = UITextField()
        textField.setTypeOfCurrency()
        textField.inputView = typeOfCurrencyOutputPickerView
        textField.inputAccessoryView = self.doneToolBar
        return textField
    }()
    
    private let typeOfCurrencyInputPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private let typeOfCurrencyOutputPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private lazy var replaceButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImages.Converter.convertButtonImage, for: .normal)
        button.addTarget(self, action: #selector(replaceButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var currencyOutputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [typeOfCurrencyOutputTextField,
                                                       currencyOutputTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = AppLayout.Converter.spacingValueOfCurrencyStackView
        return stackView
    }()
    
    private lazy var currencyInputTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 3
        textField.setCurrency()
        textField.keyboardType = .decimalPad
        textField.inputAccessoryView = self.doneToolBar
        textField.addTarget(self, action:  #selector(currencyInputTextFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    private let currencyOutputTextField: UITextField = {
        let textField = UITextField()
        textField.setCurrency()
        textField.isEnabled = false
        return textField
    }()
    
    private lazy var copyToBufferButton: UIButton = {
        let button = UIButton()
        button.setCopyButton()
        button.setTitle(AppText.Converter.copyToBuffer, for: .normal)
        button.addTarget(self, action: #selector(copyToBufferButtonTouchUpInside), for: .touchUpInside)
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
    @objc private func replaceButtonTouchUpInside() {
        replaceButtonTouchUpInsideHandler?()
    }
    
    @objc private func doneButtonAction() {
        doneButtonActionHandler?()
    }
    
    @objc private func copyToBufferButtonTouchUpInside() {
        copyToBufferButtonTouchUpInsideHandler?()
    }
    
    @objc private func rootViewTapGestureRecognizer() {
        rootViewTapGestureRecognizerHandler?()
    }
    
    @objc private func currencyInputTextFieldEditingChanged() {
        currencyInputTextFieldEditingChangedHandler?()
    }
    
    
    // MARK: - Configure
    private func configureGestureRecognizer() {
        addGestureRecognizer(tapRootView)
    }
    
    
    private func configureMainStackView() {
        let scrollArea = self.scrollView.contentLayoutGuide
        typeOfCurrencyInputTextField.translatesAutoresizingMaskIntoConstraints = false
        typeOfCurrencyOutputTextField.translatesAutoresizingMaskIntoConstraints = false
        currencyInputTextField.translatesAutoresizingMaskIntoConstraints = false
        currencyOutputTextField.translatesAutoresizingMaskIntoConstraints = false
        replaceButton.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        nameOfCurrencyInputLabel.translatesAutoresizingMaskIntoConstraints = false
        nameOfCurrencyOutputLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            nameOfCurrencyInputLabel.widthAnchor.constraint(equalToConstant: AppLayout.Converter.widthNameOfCurrencyLabel),
            nameOfCurrencyInputLabel.heightAnchor.constraint(equalToConstant: AppLayout.Converter.heightNameOfCurrencyLabel),
            nameOfCurrencyOutputLabel.widthAnchor.constraint(equalToConstant: AppLayout.Converter.widthNameOfCurrencyLabel),
            nameOfCurrencyOutputLabel.heightAnchor.constraint(equalToConstant: AppLayout.Converter.heightNameOfCurrencyLabel),
            typeOfCurrencyInputTextField.widthAnchor.constraint(equalToConstant: AppLayout.Converter.widthTextFieldTypeOfCurrency),
            typeOfCurrencyInputTextField.heightAnchor.constraint(equalToConstant: AppLayout.Converter.heightTextField),
            typeOfCurrencyOutputTextField.widthAnchor.constraint(equalToConstant: AppLayout.Converter.widthTextFieldTypeOfCurrency),
            typeOfCurrencyOutputTextField.heightAnchor.constraint(equalToConstant: AppLayout.Converter.heightTextField),
            currencyInputTextField.widthAnchor.constraint(equalToConstant: AppLayout.Converter.widthTextFieldValueOfCurrency),
            currencyInputTextField.heightAnchor.constraint(equalToConstant: AppLayout.Converter.heightTextField),
            currencyOutputTextField.widthAnchor.constraint(equalToConstant: AppLayout.Converter.widthTextFieldValueOfCurrency),
            currencyOutputTextField.heightAnchor.constraint(equalToConstant: AppLayout.Converter.heightTextField),
            replaceButton.widthAnchor.constraint(equalToConstant: AppLayout.Converter.replaceButtonWidth),
            replaceButton.heightAnchor.constraint(equalToConstant: AppLayout.Converter.replaceButtonHeight),
            mainStackView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
                                               constant: AppLayout.Converter.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                                   constant: AppLayout.Converter.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
                                                    constant: AppLayout.Converter.trailingMainStackView)
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

// MARK: - IConverterView
extension ConverterView: IConverterView {
    
    func configure(with model: IConvertorViewModel) {
        dateLabel.text = model.date
        nameOfCurrencyInputLabel.text = model.nameOfCurrencyInput
        nameOfCurrencyOutputLabel.text = model.nameOfCurrencyOutput
        typeOfCurrencyInputTextField.text = model.typeOfCurrencyInput
        typeOfCurrencyOutputTextField.text = model.typeOfCurrencyOutput
        currencyOutputTextField.text = model.currencyOutput
    }
    
    func endEditingView() {
        endEditing(true)
    }
    
    func setPickerViewDelegate(object: UIPickerViewDataSource & UIPickerViewDelegate) {
        typeOfCurrencyInputPickerView.dataSource = object
        typeOfCurrencyInputPickerView.delegate = object
        typeOfCurrencyOutputPickerView.dataSource = object
        typeOfCurrencyOutputPickerView.delegate = object
    }
    
    func setTextFieldDelegate (object: UITextFieldDelegate) {
        typeOfCurrencyInputTextField.delegate = object
        typeOfCurrencyOutputTextField.delegate = object
        currencyInputTextField.delegate = object
    }
    
 
    func isEditingTypeOfCurrencyInputTextField () -> Bool {
        typeOfCurrencyInputTextField.isEditing
    }
    
    func isEditingTypeOfCurrencyOutputTextField () -> Bool {
        typeOfCurrencyOutputTextField.isEditing
    }
    
    func getTextCurrencyInputTextField() -> String? {
        return currencyInputTextField.text
    }
    
    func selectRowForPickerViewInput(row: Int) {
        typeOfCurrencyInputPickerView.selectRow(row,
                                                inComponent: 0,
                                                animated: false)
    }
    
    func selectRowForPickerViewOutput(row: Int) {
        typeOfCurrencyOutputPickerView.selectRow(row,
                                                 inComponent: 0,
                                                 animated: false)
    }
    
    func setScrollEnabled(enabled: Bool) {
        scrollView.isScrollEnabled = enabled
    }
    
    func setScrollContentInset(contentInsets: UIEdgeInsets) {
        scrollView.contentInset = contentInsets
    }
    
    func setScrollIndicatorInsets(contentInsets: UIEdgeInsets) {
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func getCurrencyOutputTextField() -> UITextField {
        return currencyOutputTextField
    }
    
    func scrollRectToVisible(rect: CGRect) {
        scrollView.scrollRectToVisible(rect, animated: true)
    }
}
