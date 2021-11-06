//
//  DetailsCarViewController.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 28.10.2021.
//

import UIKit

protocol DetailsCarViewControllerDelegate {
    func getNewCar(car: Car)
}

internal class DetailsCarViewController: BaseViewController<DetailsCarView>, ShowAlert {
    // MARK: - Properties
    var alertNotifications: AlertNotificationsProtocol
    var activeField: UITextField?
    let maxCharactersForYearOfCar = 4
    internal var car: Car = Car()
    var detailsCarDelegate: DetailsCarViewControllerDelegate?
    
    // MARK: - GestureRecognizer
    private let tapRootView = UITapGestureRecognizer()
    
    // MARK: Init
    internal init(alertNotifications: AlertNotificationsProtocol) {
        self.alertNotifications = alertNotifications
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    
    // MARK: - Configure
    private func configure() {
        configureNavigationBar()
        configureGestureRecognizer()
        configureTypeOfBodyPickerView()
        configureTypeOfBodyTextField()
        configureYearOfIssueTextField()
        registerForKeyboardNotifications()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        title = Text.car
        let barButtonItem = UIBarButtonItem(title: Text.done, style: .plain,
                                            target: self,
                                            action: #selector(addNodeTouchUpInsideButton))
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    private func configureGestureRecognizer() {
        tapRootView.cancelsTouchesInView = false
        tapRootView.addTarget(self, action: #selector(dismissKeyboardTapGestureRecognizer))
        rootView.addGestureRecognizer(tapRootView)
    }
    
    private func configureTypeOfBodyPickerView() {
        rootView.bodyPickerView.dataSource = self
        rootView.bodyPickerView.delegate = self
    }
    
    private func configureTypeOfBodyTextField() {
        rootView.bodyTextField.delegate = self
        rootView.bodyTextField.inputView = rootView.bodyPickerView
        rootView.bodyTextField.text = BodyOfCar.sedan.rawValue
    }
    
    private func configureYearOfIssueTextField() {
        rootView.yearOfIssueTextField.delegate = self
    }
    
    //MARK: - Private functions
    private func checkInputData() -> Bool {
        guard let manufacturer = rootView.manufacturerTextField.text,
              manufacturer != "" else {
            alertNotifications.showFailedCarManufacturer()
            return false
        }
        guard let model = rootView.modelTextField.text,
              model != "" else {
            alertNotifications.showFailedCarModel()
            return false
        }
        car.manufacturer = manufacturer
        car.model = model
        
        if let yearsOfIssue = rootView.yearOfIssueTextField.text,
           yearsOfIssue != "" {
            if let yearsOfIssueToInt = Int(yearsOfIssue) {
                car.yearsOfIssue = yearsOfIssueToInt
            } else {
                alertNotifications.showFailedInputNumberCarYearOfIssue()
                return false
            }
        }
        if let carNumber = rootView.carNumberTextField.text,
           carNumber != "" {
            car.carNumber = carNumber
        }
        return true
    }
    
    // MARK: - Keyboard
    private func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        guard let info = notification.userInfo,
              let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        else { return }
        rootView.scrollView.isScrollEnabled = true
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0,
                                                        left: 0.0,
                                                        bottom: keyboardSize.height,
                                                        right: 0.0)
        
        rootView.scrollView.contentInset = contentInsets
        rootView.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        
        if let activeField = activeField {
            if (!aRect.contains(activeField.frame.origin)){
                rootView.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        guard let info = notification.userInfo,
              let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        else { return }
        
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0,
                                                        left: 0.0,
                                                        bottom: -keyboardSize.height,
                                                        right: 0.0)
        
        rootView.scrollView.contentInset = contentInsets
        rootView.scrollView.scrollIndicatorInsets = contentInsets
        
        rootView.endEditing(true)
        rootView.scrollView.isScrollEnabled = false
    }
    
    
    // MARK: - Actions
    @objc private func addNodeTouchUpInsideButton () {
        if checkInputData() {
            detailsCarDelegate?.getNewCar(car: car)
            goToListCarsViewController()
        }
    }
    
    @objc func dismissKeyboardTapGestureRecognizer() {
        rootView.endEditing(true)
    }
    
    // MARK: - Navigation
    private func goToListCarsViewController() {
        navigationController?.popViewController(animated: true)
    }
}
