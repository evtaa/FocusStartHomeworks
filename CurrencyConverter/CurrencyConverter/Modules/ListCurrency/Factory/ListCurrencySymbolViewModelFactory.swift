//
//  ListCurrencySymbolViewModelFactory.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import Foundation

final class ListCurrencySymbolViewModelFactory {
    static func createSymbolViewModel(symbol: Symbol) -> IListCurrencySymbolViewModel {
        let descriptionAndCode: String
        if let codeString = symbol.code,
           let description = symbol.symbolDescription {
            descriptionAndCode = description + " (" + codeString + ")"
        } else {
            descriptionAndCode = "Unknown"
        }
        return ListCurrencySymbolViewModel(descriptionAndCode: descriptionAndCode)
    }
}
