//
//  ListEmployeeAssembler.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

final class ListEmployeeAssembler {
    static func assemble(employeeStorage: IEmployeeStorage, company: CompanyModel) -> ListEmployeeController {
        let router = ListEmployeeRouter()
        let model = ListEmployeeModel()
        let tableViewDataHandler = ListEmployeeTableViewDataHandler()
        let presenter = ListEmployeePresenter(dependencies: .init(model: model,
                                                                 router: router,
                                                                 tableViewDataHandler: tableViewDataHandler,
                                                                 employeeStorage: employeeStorage,
                                                                 company: company))
        let controller = ListEmployeeController(dependencies: .init(presenter: presenter))
        return controller
    }
}
