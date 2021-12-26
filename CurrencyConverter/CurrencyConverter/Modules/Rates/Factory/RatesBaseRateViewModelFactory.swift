//
//  RatesInfoForRatesViewModelFactory.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

final class RatesBaseRateViewModelFactory {
    static func createBaseRateViewModel(baseRate: Rate) -> IRatesBaseRateViewModel {
        let baseCurrency: String = (baseRate.symbolDescription ?? "Unknown") + " (" + (baseRate.code ?? "Unknown") + ")"
        return RatesBaseRateViewModel(baseCurrency: baseCurrency)
    }
}
