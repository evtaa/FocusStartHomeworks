//
//  RatesDTO.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

// MARK: - Welcome
class RatesDTO: Codable {
    let success: Bool?
    let historical: Bool?
    let base: String?
    let date: String?
    let rates: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case historical = "historical"
        case base = "base"
        case date = "date"
        case rates = "rates"
    }

    init(success: Bool?, historical: Bool?, base: String?, date: String?, rates: [String: Double]?) {
        self.success = success
        self.historical = historical
        self.base = base
        self.date = date
        self.rates = rates
    }
}
