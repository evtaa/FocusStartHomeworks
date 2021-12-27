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
    
    func sortArrayOfSymbol()
}

final class ListCurrencyModel {
    var arrayOfSymbol: [Symbol]?
    var infoForRates: InfoForRates?
    
}

// MARK: - IListCurrencyModel
extension ListCurrencyModel: IListCurrencyModel{
    func sortArrayOfSymbol() {
        let sortArrayOfSymbol = arrayOfSymbol?.sorted(by: {
            guard let firstRate = $0.code,
                  let secondRate = $1.code
            else { return false }
            return firstRate < secondRate
        })
        arrayOfSymbol = sortArrayOfSymbol
    }
}
