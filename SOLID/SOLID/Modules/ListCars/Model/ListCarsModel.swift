//
//  ListCarsModel.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import Foundation

protocol IListCarsModel {
    func fetchListCars(closure: @escaping (([Car]) -> Void))
}

final class ListCarsModel {
}

// MARK: - IListCarsModel
extension ListCarsModel: IListCarsModel{
    func fetchListCars(closure: @escaping (([Car]) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now()) {
            closure(CarsMock.shared.cars)
        }
    }
}
