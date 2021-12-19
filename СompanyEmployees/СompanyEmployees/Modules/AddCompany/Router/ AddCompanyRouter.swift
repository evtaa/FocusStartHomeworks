//
//   AddCompanyRouter.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import Foundation

protocol IAddCompanyRouter {
    var backToListCompanyHandler: (() -> Void)? { get set }
    
    func backToListCompany()
}

final class AddCompanyRouter {
    // MARK: - Handlers
    var backToListCompanyHandler: (() -> Void)?
}

// MARK: - IAddCompanyRouter
extension AddCompanyRouter: IAddCompanyRouter{
    
    func backToListCompany() {
        backToListCompanyHandler?()
    }
}


