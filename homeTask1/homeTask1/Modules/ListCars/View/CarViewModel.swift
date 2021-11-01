//
//  CarViewModel.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import Foundation

struct CarViewModel {
    var manufacturer: String
    var model: String
    var body: String
    var yearOfIssue: String
    var carNumber: String?
}

final class CarViewModelFactory {
    
    static func cellModel (from car: Car) -> CarViewModel {
        let manufacturer: String = "The manufacturer: \(car.manufacturer)"
        let model: String = "The model: \(car.model)"
        let body: String = "The body: \(car.body)"
        var newYearOfIssue: String = "The year of an issue: "
        var newCarNumber: String? = ""
        
        if let yearOfIssue = car.yearsOfIssue,
           String(yearOfIssue) != "" {
            newYearOfIssue += "\(yearOfIssue)"
        } else {
            newYearOfIssue += "-"
        }
        
        if let carNumber = car.carNumber,
           String(carNumber) != ""
           {
            newCarNumber! += "The car number: \(carNumber)"
        } else {
            newCarNumber = nil
        }
        
        return CarViewModel(manufacturer: manufacturer,
                            model: model,
                            body: body,
                            yearOfIssue: newYearOfIssue,
                            carNumber: newCarNumber)
    }
}
