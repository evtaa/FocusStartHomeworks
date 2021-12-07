//
//  AppColors.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import UIKit

enum AppColors {
    static let backgroundColor = UIColor.systemBackground
    enum ListCars {
        enum Cell {
            static let markViewEvenColor = UIColor(named: "markColorEven") ?? UIColor()
            static let markViewColorOdd = UIColor(named: "markColorOdd") ?? UIColor()
            static let buttonColor = UIColor.clear
            static let buttonTitleColor = UIColor.black
            
        }
    }
    enum DetailsCar {
        static let textButtonItem = UIColor(named: "buttonColor")
        static let activityIndicator = UIColor.systemBlue
        static let textButtonColor = UIColor.white
        static let buttonColor = UIColor(named: "buttonColor")
        enum Cell {
            static let buttonColor = UIColor(named: "buttonColor")
        }
    }
}
