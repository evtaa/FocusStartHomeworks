//
//  AppText.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import Foundation

enum AppText {
    enum ListCars {
        static let title = "Выберите"
        enum Cell {
            static let buttonText = "Select"
            static let headerOfTable = "Марку машины"
        }
    }
    
    enum DetailsCar {
        static let leftButtonItem = "Back"
        static let costLabel = "Цена"
        static let calculateCostButton = "Расчитать цену"
        enum Cell {
            static let headerOfTable = "Выберите тип кузова"
        }
    }
}
