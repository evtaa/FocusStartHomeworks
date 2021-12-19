//
//  ListCompanyAssembler.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import Foundation

final class ListCompanyAssembler {
    static func assemble(companyStorage: ICompanyStorage) -> ListCompanyController {
        let router = ListCompanyRouter()
        let model = ListCompanyModel()
        let tableViewDataHandler = ListCompanyTableViewDataHandler()
        let presenter = ListCompanyPresenter(dependencies: .init(model: model,
                                                                 router: router,
                                                                 tableViewDataHandler: tableViewDataHandler,
                                                                 companyStorage: companyStorage))
        let controller = ListCompanyController(dependencies: .init(presenter: presenter))
        return controller
    }
}
