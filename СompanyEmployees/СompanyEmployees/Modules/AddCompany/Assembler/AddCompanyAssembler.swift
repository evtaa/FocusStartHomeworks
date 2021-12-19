//
//  AddCompanyAssembler.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import UIKit

final class AddCompanyAssembler {
    static func assemble(companyStorage: ICompanyStorage) -> AddCompanyController {
        let router = AddCompanyRouter()
        let model = AddCompanyModel()
        let presenter = AddCompanyPresenter(dependencies: .init(model: model,
                                                                router: router,
                                                                companyStorage: companyStorage))
        let controller = AddCompanyController(dependencies: .init(presenter: presenter))
        return controller
    }
}
