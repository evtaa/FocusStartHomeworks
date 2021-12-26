//
//  Symbol.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import Foundation

final class Symbol {
    private(set) var symbolDescription: String?
    private(set) var code: String?
    
    init (symbolDTO: SymbolDTO) {
        self.code = symbolDTO.code
        self.symbolDescription = symbolDTO.symbolDescription
    }
}
    
   
