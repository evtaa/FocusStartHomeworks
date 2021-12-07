//
//  ListCarsRouter.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import Foundation

protocol IListCarsRouter {
    func goToDetailsCar(idOfCar: UUID)
    var goToDetailsCarHandler: ((_ idOfCar: UUID) -> Void)? { get set }
}

final class ListCarsRouter {
    // MARK: - Handlers
    var goToDetailsCarHandler: ((_ idOfCar: UUID) -> Void)?
}

// MARK: - IListCarsRouter
extension ListCarsRouter: IListCarsRouter{
    func goToDetailsCar(idOfCar: UUID) {
        goToDetailsCarHandler?(idOfCar)
    }
}
