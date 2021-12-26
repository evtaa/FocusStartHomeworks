//
//  Button.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import UIKit

extension UIButton {
    func setAuthButton() {
        self.setTitleColor(AppColors.Auth.buttonTextNormalColor,
                           for: .normal)
        self.setTitleColor(AppColors.Auth.buttonTextHighlightedColor,
                           for: .highlighted)
    }
    
    func setCopyButton() {
        self.setTitleColor(AppColors.Auth.buttonTextNormalColor,
                           for: .normal)
        self.setTitleColor(AppColors.Auth.buttonTextHighlightedColor,
                           for: .highlighted)
        self.titleLabel?.font = AppFont.system
    }
}
