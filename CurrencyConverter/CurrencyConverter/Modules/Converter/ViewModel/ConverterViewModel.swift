//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import Foundation

protocol IConvertorViewModel {
    var typeOfCurrencyInput: String { get }
    var typeOfCurrencyOutput: String { get }
    var currencyOutput: String { get }
    var date: String { get }
    var nameOfCurrencyInput: String { get }
    var nameOfCurrencyOutput: String { get }
}

struct ConvertorViewModel: IConvertorViewModel {
    private(set) var typeOfCurrencyInput: String
    private(set) var typeOfCurrencyOutput: String
    private(set) var currencyOutput: String
    private(set) var date: String
    private(set) var nameOfCurrencyInput: String
    private(set) var nameOfCurrencyOutput: String
}
