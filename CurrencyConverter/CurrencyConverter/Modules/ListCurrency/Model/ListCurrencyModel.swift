//
//  ListCurrencyModel.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import Foundation

protocol IListCurrencyModel {
    var arrayOfSymbol: [Symbol]? { get set }
    var infoForRates: InfoForRates? { get set }
}

final class ListCurrencyModel {
    var arrayOfSymbol: [Symbol]?
    var infoForRates: InfoForRates?
    
}

// MARK: - IListCurrencyModel
extension ListCurrencyModel: IListCurrencyModel{
   
}
