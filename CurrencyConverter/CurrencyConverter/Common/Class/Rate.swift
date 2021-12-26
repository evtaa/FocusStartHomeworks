//
//  Rate.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

final class Rate {
    private(set) var symbolDescription: String?
    private(set) var code: String?
    private(set) var rate: Double?
    
    init (symbolDescription: String?,
          code: String?,
          rate: Double?) {
        self.symbolDescription = symbolDescription
        self.code = code
        self.rate = rate
    }
}
