//
//  ListCarsPickerViewDelegate.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 06.11.2021.
//

import Foundation
import UIKit

extension ListCarsViewController: UIPickerViewDataSource {
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        BodyOfCarForPickerView.allCases.count
    }
}

extension ListCarsViewController: UIPickerViewDelegate {
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        BodyOfCarForPickerView.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        selectedBodyOfCar = BodyOfCarForPickerView.allCases[row]
        searchController.searchBar.searchTextField.text =  selectedBodyOfCar.rawValue
        setFilterShownCarsBySelectedBody()
        searchController.searchBar.endEditing(true)
        rootView.typeOfBodyPickerView.isHidden = true
    }
}


