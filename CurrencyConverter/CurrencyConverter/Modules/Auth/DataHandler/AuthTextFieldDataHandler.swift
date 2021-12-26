//
//  AuthTextFieldDataHandler.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import UIKit

protocol IAuthTextFieldDataHandler: UITextFieldDelegate {
}

final class AuthTextFieldDataHandler: NSObject {
    
}

// MARK: - UITextFieldDelegate
extension AuthTextFieldDataHandler: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard !string.isEmpty else {
            return true
        }
        if CharacterSet(charactersIn: "!@#$%^&*()-_=+/|.,\\:;[]{}'?<>`~\"").isSuperset(of: CharacterSet(charactersIn: string)) {
            return false
        }
        if let text = textField.text,
           let range = Range(range, in: text) {
            let proposedText = text.replacingCharacters(in: range, with: string)
            if proposedText.count <= AppLayout.Auth.maxCountOfCharacters {
                return true
            }
        }
        
        return false
    }
    
}

// MARK: - IConverterTextFieldDataHandler
extension AuthTextFieldDataHandler: IAuthTextFieldDataHandler {
    
}
