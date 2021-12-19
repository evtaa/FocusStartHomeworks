//
//  EditEmployeeAssembler.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

final class EditEmployeeAssembler {
    static func assemble(employeeStorage: IEmployeeStorage, employee: EmployeeModel) -> EditEmployeeController {
        let router = EditEmployeeRouter()
        let model = EditEmployeeModel()
        let presenter = EditEmployeePresenter(dependencies: .init(model: model,
                                                                  router: router,
                                                                  employeeStorage: employeeStorage,
                                                                  employee: employee))
        let controller = EditEmployeeController(dependencies: .init(presenter: presenter))
        return controller
    }
}
