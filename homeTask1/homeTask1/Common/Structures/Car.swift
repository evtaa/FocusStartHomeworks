//
//  Car.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import Foundation

struct Car {
    
    // MARK: - Properties
    var manufacturer: String = ""
    var model: String = ""
    var body: BodyOfCar = .sedan
    var yearsOfIssue: Int? = nil
    var carNumber: String? = nil
    
    // MARK: - Inits
    init(manufacturer: String,
         model: String,
         body: BodyOfCar,
         yearsOfIssue: Int?,
         carNumber: String?) {
        self.manufacturer = manufacturer
        self.model = model
        self.body = body
        self.yearsOfIssue = yearsOfIssue
        self.carNumber = carNumber
    }
    
    init() {}
}
