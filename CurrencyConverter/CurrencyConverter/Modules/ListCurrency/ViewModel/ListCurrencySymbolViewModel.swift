//
//  ListCurrencySymbolViewModel.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import Foundation

protocol IListCurrencySymbolViewModel {
    var descriptionAndCode: String { get }
}

struct ListCurrencySymbolViewModel: IListCurrencySymbolViewModel {
    private(set) var descriptionAndCode: String
}
