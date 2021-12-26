//
//  TextField.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 22.12.2021.
//

import UIKit

extension UITextField {
    func setAuthTextField() {
        self.keyboardType = .default
        self.font = AppFont.system
        self.borderStyle = .roundedRect
        self.autocorrectionType = UITextAutocorrectionType.no
        self.textAlignment = .center
    }
}
