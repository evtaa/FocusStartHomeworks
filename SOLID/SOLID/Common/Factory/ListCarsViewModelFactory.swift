//
//  ListCarsViewModelFactory.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import Foundation

final class ListCarsViewModelFactory {
    static func getViewModel(from car: Car) -> ListCarsViewModel {
        let makeOfCar = car.makeOfCar.rawValue
        return ListCarsViewModel(makeOfCar: makeOfCar)
    }
}
