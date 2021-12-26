//
//  AppImages.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 22.12.2021.
//

import UIKit

enum AppImages {
    
    enum Tabs {
        static let convertor = UIImage(named: "convertor")
        static let convertorSelect = UIImage(named: "convertorSelect")
        static let listCurrency = UIImage(named: "listCurrency")
        static let listCurrencySelect = UIImage(named: "listCurrencySelect")
    }
    
    enum Converter {
        static let convertButtonImage: UIImage = UIImage(named: "replace") ?? UIImage()
        static let equalImage: UIImage = UIImage(named: "equal") ?? UIImage()
    }
}
