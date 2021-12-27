//
//  AddEmployeeRouter.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IAddEmployeeRouter {
    var backToListEmployeeHandler: (() -> Void)? { get set }
    
    func backToListEmployee()
}

final class AddEmployeeRouter {
    // MARK: - Handlers
    var backToListEmployeeHandler: (() -> Void)?
}

// MARK: - IAddEmployeeRouter
extension AddEmployeeRouter: IAddEmployeeRouter{
    
    func backToListEmployee() {
        backToListEmployeeHandler?()
    }
}
