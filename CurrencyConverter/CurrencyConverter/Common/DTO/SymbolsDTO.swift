//
//  Symbols.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import Foundation

// MARK: - Welcome
class SymbolsDTO: Codable {
    let success: Bool?
    let symbols: [String: SymbolDTO]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case symbols = "symbols"
    }
    
    init(success: Bool?, symbols: [String: SymbolDTO]?) {
        self.success = success
        self.symbols = symbols
    }
}

// MARK: - Symbol
class SymbolDTO: Codable {
    let symbolDescription: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case symbolDescription = "description"
        case code = "code"
    }
    
    init(symbolDescription: String?, code: String?) {
        self.symbolDescription = symbolDescription
        self.code = code
    }
}
