//
//  ListCompanyRouter.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import Foundation

protocol IListCompanyRouter {
    var goToAddCompanyDataHandler: (() -> Void)? { get set }
    var goToListEmployeeDataHandler: ((_ company: CompanyModel) -> Void)? { get set }
    func goToAddCompany()
    func goToListEmployee(company: CompanyModel)
}

final class ListCompanyRouter {
    // MARK: - Handlers
    var goToAddCompanyDataHandler: (() -> Void)?
    var goToListEmployeeDataHandler: ((_ company: CompanyModel) -> Void)?
}

// MARK: - IListCarsRouter
extension ListCompanyRouter: IListCompanyRouter{
    func goToAddCompany() {
        goToAddCompanyDataHandler?()
    }
    
    func goToListEmployee(company: CompanyModel) {
        goToListEmployeeDataHandler?(company)
    }
}
