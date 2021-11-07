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
        let manufacturer: String = "\(Text.manufacturerIs) \(car.manufacturer)"
        let model: String = "\(Text.modelIs) \(car.model)"
        let body: String = "\(Text.bodyIs) \(car.body.rawValue)"
        var newYearOfIssue: String = "\(Text.yearOfIssueIs) "
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
            newCarNumber! += "\(Text.carNumberIs) \(carNumber)"
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
