//
//  UITextFieldDelegate.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 07.11.2021.
//

import Foundation
import UIKit

//MARK: - UITextFieldDelegate
extension DetailsCarViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        rootView.bodyPickerView.isHidden = false
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard textField === rootView.yearOfIssueTextField else {return false}
        guard !string.isEmpty else {
            // Backspace detected
            return true
        }
        
        if textField.keyboardType == .numberPad {
            if !CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) {
                alertNotifications.showFailedInputNumberCarYearOfIssue()
                return false
            }
        }
        
        if let text = textField.text,
           let range = Range(range, in: text) {
            let proposedText = text.replacingCharacters(in: range, with: string)
            guard proposedText.count <= maxCharactersForYearOfCar else {
                if string.count > 1 {
                    alertNotifications.showFailedCountOfNumberCarYearOfIssue()
                }
                return false
            }
        }
        return true
    }
}
