//
//  ListEmployeeRouter.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IListEmployeeRouter {
    var goToAddEmployeeDataHandler: (() -> Void)? { get set }
    var goToEditEmployeeDataHandler: ((_ employee: EmployeeModel) -> Void)? { get set }
    func goToAddEmployee()
    func goToEditEmployee(employee: EmployeeModel)
}

final class ListEmployeeRouter {
    // MARK: - Handlers
    var goToAddEmployeeDataHandler: (() -> Void)?
    var goToEditEmployeeDataHandler: ((_ employee: EmployeeModel) -> Void)?
}

// MARK: - IListCarsRouter
extension ListEmployeeRouter: IListEmployeeRouter{
    func goToAddEmployee() {
        goToAddEmployeeDataHandler?()
    }
    
    func goToEditEmployee(employee: EmployeeModel) {
        goToEditEmployeeDataHandler?(employee)
    }
    
}
