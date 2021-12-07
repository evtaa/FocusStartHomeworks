//
//  DetailsCarRouter.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import Foundation

protocol IDetailsCarRouter {
    func backToListCars()
    var backToListCarsHandler: (() -> Void)? { get set }
}

final class DetailsCarRouter {
    // MARK: - Handlers
    var backToListCarsHandler: (() -> Void)?
}

// MARK: - IListCarsRouter
extension DetailsCarRouter: IDetailsCarRouter{
    func backToListCars() {
        backToListCarsHandler?()
    }
}

