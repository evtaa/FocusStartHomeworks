//
//  RatesSymbolViewModel.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

protocol IRatesRateViewModel {
    var description: String { get }
    var rateAndCode: String { get }
}

struct RatesRateViewModel: IRatesRateViewModel {
    private(set) var description: String
    private(set) var rateAndCode: String
}
