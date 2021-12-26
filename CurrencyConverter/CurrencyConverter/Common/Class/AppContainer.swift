//
//  AppContainer.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

final class AppContainer {
    private(set) var networkService = NetworkService()
    private(set) var coreDataService = CoreDataService()
    private(set) var pasteboardService = PasteboardService()
}
