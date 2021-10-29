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

class DetailsCarViewController: BaseViewController<DetailsCarView>, ShowAlert {
    // MARK: - Properties
    var car: Car = Car()
    var delegate: DetailsCarViewControllerDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        configureNavigationBar()
        configureTypeOfBodyPickerView()
        configureTypeOfBodyTextField()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        title = "Car"
        let barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addNodeTouchUpInsideButton))
        navigationItem.setRightBarButton(barButtonItem, animated: true)
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
    
    //MARK: - Private functions
    private func checkInputData() -> Bool {
        guard let manufacturer = rootView.manufacturerTextField.text,
              manufacturer != "" else {
            showFailedCarManufacturer()
            return false
        }
        guard let model = rootView.modelTextField.text,
              model != "" else {
            showFailedCarModel()
            return false
        }
        car.manufacturer = manufacturer
        car.model = model
        
        if let yearsOfIssue = rootView.yearOfIssueTextField.text,
           yearsOfIssue != "" {
            if let yearsOfIssueToInt = Int(yearsOfIssue) {
                car.yearsOfIssue = yearsOfIssueToInt
            } else {
                showFailedCarYearOfIssue()
                return false
            }
        }
        
        if let carNumber = rootView.carNumberTextField.text,
           carNumber != "" {
            car.carNumber = carNumber
        }
        return true
    }
    
    // MARK: - Actions
    @objc private func addNodeTouchUpInsideButton () {
        if checkInputData() {
            delegate?.getNewCar(car: car)
            goToListCarsViewController()
        }
    }
    
    // MARK: - Navigation
    private func goToListCarsViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ShowAlert
    func  showFailedCarManufacturer () {
        showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "You did't enter a car manufacturer", withTitleOfAction: "OK", handlerOfAction: nil)
    }
    
    func  showFailedCarModel () {
        showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "You didn't enter a car model", withTitleOfAction: "OK", handlerOfAction: nil)
    }
    
    func  showFailedCarYearOfIssue () {
        showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "You should enter number for a car year of an issue. No string.", withTitleOfAction: "OK", handlerOfAction: nil)
    }
}

//MARK: - UIPickerViewDataSource
extension DetailsCarViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        BodyOfCar.allCases.count
    }
}

//MARK: - UIPickerViewDelegate
extension DetailsCarViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        BodyOfCar.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = BodyOfCar.allCases[row]
        car.body = selectedValue
        rootView.bodyTextField.text = selectedValue.rawValue
        rootView.endEditing(true)
        rootView.bodyPickerView.isHidden = true
    }
}

//MARK: - UITextFieldDelegate
extension DetailsCarViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        rootView.bodyPickerView.isHidden = false
        return true
    }
}
