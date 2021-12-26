//
//  ConverterTextFieldDataHandler.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 22.12.2021.
//

import UIKit

protocol IConverterTextFieldDataHandler: UITextFieldDelegate {
}

final class ConverterTextFieldDataHandler: NSObject {
}

// MARK: - UITextFieldDelegate
extension ConverterTextFieldDataHandler: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField.tag == 3 {
            guard !string.isEmpty else {
                return true
            }
            if !CharacterSet(charactersIn: "0123456789.").isSuperset(of: CharacterSet(charactersIn: string)) {
                return false
            }
            if let text = textField.text,
               let range = Range(range, in: text) {
                let proposedText = text.replacingCharacters(in: range, with: string)
                if proposedText.count <= AppLayout.Converter.maxCountOfCharacters {
                    return true
                }
            }
        }
        return true
    }
}

// MARK: - IConverterTextFieldDataHandler
extension ConverterTextFieldDataHandler: IConverterTextFieldDataHandler {
    
}
