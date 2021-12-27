//
//  ListCurrencyView.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import UIKit

protocol IListCurrencyView: UIView {
    var rootViewTapGestureRecognizerHandler: (() -> Void)? { get set }
    var doneButtonActionHandler: (() -> Void)? { get set }
    var backButtonActionHandler: (() -> Void)? { get set }

    
    func endEditingView()
    func setTableViewDelegates(object : UITableViewDataSource & UITableViewDelegate)
    func registerTableViewCell (_ cellType: UITableViewCell.Type)
    func registerTableViewHeaderCell (_ cellType: UITableViewHeaderFooterView.Type)
    func reloadData ()
    func becomeFirstResponderForDateTextField()
    func getDateFromPickerView() -> Date
}

final class ListCurrencyView: UIView {
    
    //MARK: - Handlers
    var rootViewTapGestureRecognizerHandler: (() -> Void)?
    var doneButtonActionHandler: (() -> Void)?
    var backButtonActionHandler: (() -> Void)?
    
    // MARK: SubViews
    private lazy var doneToolBar: UIToolbar = {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0,
                                                                  y: 0,
                                                                  width: AppLayout.widthScreen,
                                                                  height: AppLayout.Converter.heightDoneButton))
        doneToolbar.barStyle = .default
        let back = UIBarButtonItem(barButtonSystemItem: .cancel,
                                   target: self,
                                   action:  #selector(backButtonAction))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done,
                                   target: self,
                                   action: #selector(doneButtonAction))
        let items = [back, flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        return doneToolbar
    }()
    
    private let datePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.preferredDatePickerStyle = .inline
        pickerView.maximumDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let minDate = dateFormatter.date(from: AppText.ListCurrency.minDateString)
        pickerView.minimumDate = minDate
        return pickerView
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.inputView = datePicker
        textField.inputAccessoryView = self.doneToolBar
        return textField
    }()
    
    private lazy var tapRootView: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.cancelsTouchesInView = false
        recognizer.addTarget(self, action: #selector(rootViewTapGestureRecognizer))
        return recognizer
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = AppLayout.ListCurrency.tableEstimatedRowHeight
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayoutView()
        configureGestureRecognizer()
        backgroundColor = AppColors.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    @objc private func rootViewTapGestureRecognizer() {
        rootViewTapGestureRecognizerHandler?()
    }
    
    @objc private func doneButtonAction() {
        doneButtonActionHandler?()
    }
    
    @objc private func backButtonAction() {
        backButtonActionHandler?()
    }
    
    // MARK: - Configure
    private func configureGestureRecognizer() {
        addGestureRecognizer(tapRootView)
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        addSubview(dateTextField)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.ListCurrency.topTableView),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.ListCurrency.leadingTableView),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.ListCurrency.trailingTableView),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: AppLayout.ListCurrency.bottomTableView)
        ])
    }
}

// MARK: - IListCurrencyView
extension ListCurrencyView: IListCurrencyView {
    func endEditingView() {
        endEditing(true)
    }
    
    func setTableViewDelegates(object : UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = object
        tableView.delegate = object
    }
    
    func registerTableViewCell (_ cellType: UITableViewCell.Type) {
        tableView.register(cellType)
    }
    
    func registerTableViewHeaderCell (_ cellType: UITableViewHeaderFooterView.Type) {
        tableView.register(cellType)
    }
    
    func reloadData () {
        tableView.reloadData()
    }
    
    func becomeFirstResponderForDateTextField() {
        dateTextField.becomeFirstResponder()
    }
    
    func getDateFromPickerView() -> Date {
        return datePicker.date
    }
}
