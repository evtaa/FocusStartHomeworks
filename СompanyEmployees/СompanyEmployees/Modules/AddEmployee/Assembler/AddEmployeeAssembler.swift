//
//  AddEmployeeAssembler.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

final class AddEmployeeAssembler {
    static func assemble(employeeStorage: IEmployeeStorage, company: CompanyModel) -> AddEmployeeController {
        let router = AddEmployeeRouter()
        let model = AddEmployeeModel()
        let presenter = AddEmployeePresenter(dependencies: .init(model: model,
                                                                 router: router,
                                                                 employeeStorage: employeeStorage,
                                                                 company: company))
        let controller = AddEmployeeController(dependencies: .init(presenter: presenter))
        return controller
    }
}
