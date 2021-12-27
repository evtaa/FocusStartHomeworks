//
//  ListImagesAssemble.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import Foundation

final class ListImagesAssembler {
    static func assemble() -> ListImagesController {
        let router = ListImagesRouter()
        let model = ListImagesModel()
        let networkService = NetworkService()
        let tableViewDataHandler = ListImagesTableViewDataHandler()
        let searchControllerDataHandler = ListImagesSearchControllerDataHandler()
        
        let presenter = ListImagesPresenter(model: model,
                                            router: router,
                                            networkService: networkService,
                                            tableViewDataHandler: tableViewDataHandler,
                                            searchControllerDataHandler: searchControllerDataHandler
        )
        let controller = ListImagesController(presenter: presenter)
        return controller
    }
}
