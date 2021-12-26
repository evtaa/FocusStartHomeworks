//
//  ConverterSymbolViewModelFactory.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import Foundation

final class ConvertorSymbolViewModelFactory {
    static func createSymbolViewModel(symbol: Symbol) -> IConvertorSymbolViewModel {
        let codeAndDescription: String
        if let codeString = symbol.code,
           let description = symbol.symbolDescription {
            codeAndDescription = codeString + " " + description
        } else {
            codeAndDescription = "Unknown"
        }
        return ConvertorSymbolViewModel(codeAndDescription: codeAndDescription)
    }
}
