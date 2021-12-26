//
//  AuthRouter.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import Foundation

protocol IAuthRouter {
    var goToConverterHandler: (() -> Void)? { get set }
    
    func goToConverter()
}

final class AuthRouter {
    // MARK: - Handlers
    var goToConverterHandler: (() -> Void)?
}

// MARK: - IAuthRouter
extension AuthRouter: IAuthRouter{
    func goToConverter() {
        goToConverterHandler?()
    }
}

