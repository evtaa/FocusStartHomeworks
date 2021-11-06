//
//  DetailsCarPickerViewDelegate.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 06.11.2021.
//

import Foundation
import UIKit

extension DetailsCarViewController: UIPickerViewDataSource {
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        BodyOfCar.allCases.count
    }
}

extension DetailsCarViewController: UIPickerViewDelegate {
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        BodyOfCar.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        let selectedValue = BodyOfCar.allCases[row]
        car.body = selectedValue
        rootView.bodyTextField.text = selectedValue.rawValue
        rootView.endEditing(true)
        rootView.bodyPickerView.isHidden = true
    }
}
