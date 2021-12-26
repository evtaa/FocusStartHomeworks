//
//  SymbolViewModel.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import Foundation

protocol IConvertorSymbolViewModel {
    var codeAndDescription: String { get }
}

struct ConvertorSymbolViewModel: IConvertorSymbolViewModel {
    private(set) var codeAndDescription: String
}
