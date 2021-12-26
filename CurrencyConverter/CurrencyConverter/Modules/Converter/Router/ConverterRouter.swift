//
//  ConverterRouter.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import Foundation

protocol IConverterRouter {
    var goToAuthHandler: (() -> Void)? { get set }
    
    func goToAuth()
}

final class ConverterRouter {
    // MARK: - Handlers
    var goToAuthHandler: (() -> Void)?
}

// MARK: - IRouter
extension ConverterRouter: IConverterRouter{
    func goToAuth() {
        goToAuthHandler?()
    }
}
