//
//  ListCurrencyRouter.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import Foundation

protocol IListCurrencyRouter {
    var goToAuthHandler: (() -> Void)? { get set }
    var goToRatesHandler: (() -> Void)? { get set }
    
    func goToAuth()
    func goToRates()
}

final class ListCurrencyRouter {
    // MARK: - Handlers
    var goToAuthHandler: (() -> Void)?
    var goToRatesHandler: (() -> Void)?
}

// MARK: - IListCurrencyRouter
extension ListCurrencyRouter: IListCurrencyRouter{
    func goToAuth() {
        goToAuthHandler?()
    }
    
    func goToRates() {
        goToRatesHandler?()
    }
}

