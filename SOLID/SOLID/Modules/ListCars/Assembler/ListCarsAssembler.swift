//
//  ListCarsAssembler.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import Foundation

final class ListCarsAssembler {
    static func assemble() -> ListCarsController {
        let router = ListCarsRouter()
        let model = ListCarsModel()
        let dataHandler = ListCarsDataHandler()
        let presenter = ListCarsPresenter(model: model, router: router, dataHandler: dataHandler)
        let controller = ListCarsController(presenter: presenter)
        return controller
    }
}
