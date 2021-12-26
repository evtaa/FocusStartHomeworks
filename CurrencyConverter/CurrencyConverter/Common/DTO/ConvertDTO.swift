//
//  Convert.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import Foundation

// MARK: - Convert
class ConvertDTO: Codable {
    let success: Bool?
    let historical: Bool?
    let date: String?
    let result: Double?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case historical = "historical"
        case date = "date"
        case result = "result"
    }

        init(success: Bool?, historical: Bool?, date: String?, result: Double?) {
        self.success = success
        self.historical = historical
        self.date = date
        self.result = result
    }
}
