//
//  CarsMock.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import Foundation
import UIKit

final class CarsMock {
    
    // MARK: - Properties
    static let shared = CarsMock()
    var cars: [Car]
    
    // MARK: - Init
    private init() {
        let firstCar = Car(manufacturer: "Ford", model: "Focus" , body: .sedan, yearsOfIssue: nil, carNumber: "123")
        let secondCar = Car (manufacturer: "Mitsubishi", model: "Outlander", body: .universal, yearsOfIssue: 2001, carNumber: "")
        let thirdCar = Car (manufacturer: "Honda", model: "Civic", body: .hatchback, yearsOfIssue: 2005, carNumber: "789")
        let fourthCar = Car(manufacturer: "Toyota", model: "Landrover" , body: .coupe, yearsOfIssue: nil, carNumber: "012")
        cars = [firstCar, secondCar, thirdCar, fourthCar]
    }
}
