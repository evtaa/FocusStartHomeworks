//
//  DetailsCarAssembler.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import UIKit

final class DetailsCarAssembler {
    static func assemble(idOfCar: UUID) -> DetailsCarController {
        let router = DetailsCarRouter()
        let model = DetailsCarModel()
        let dataHandler = DetailsCarDataHandler()
        let presenter = DetailsCarPresenter(model: model, router: router, dataHandler: dataHandler, idOfCar: idOfCar)
        let controller = DetailsCarController(presenter: presenter)
        return controller
    }
}
