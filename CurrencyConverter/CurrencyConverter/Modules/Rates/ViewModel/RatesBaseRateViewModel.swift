//
//  RatesInfoForRatesViewModel.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

protocol IRatesBaseRateViewModel {
    var baseCurrency: String { get }
}

struct RatesBaseRateViewModel: IRatesBaseRateViewModel {
    private(set) var baseCurrency: String
}
