//
//  EditEmployeeRouter.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IEditEmployeeRouter {
    var backToListEmployeeHandler: (() -> Void)? { get set }
    
    func backToListEmployee()
}

final class EditEmployeeRouter {
    // MARK: - Handlers
    var backToListEmployeeHandler: (() -> Void)?
}

// MARK: - IEditEmployeeRouter
extension EditEmployeeRouter: IEditEmployeeRouter{
    
    func backToListEmployee() {
        backToListEmployeeHandler?()
    }
}
