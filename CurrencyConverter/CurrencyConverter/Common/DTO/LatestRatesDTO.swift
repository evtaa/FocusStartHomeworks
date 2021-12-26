//
//  LatestRates.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import Foundation

// MARK: - LatestRates
class LatestRatesDTO: Codable {
    let success: Bool?
    let base: String?
    let date: String?
    let rates: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case base = "base"
        case date = "date"
        case rates = "rates"
    }
    
    init( success: Bool?, base: String?, date: String?, rates: [String: Double]?) {
        self.success = success
        self.base = base
        self.date = date
        self.rates = rates
    }
}
