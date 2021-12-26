//
//  ListCurrencyAssembler.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import UIKit

final class ListCurrencyAssembler {
    static func assemble() -> ListCurrencyController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        { return nil }
        let router = ListCurrencyRouter()
        let model = ListCurrencyModel()
        let networkService = appDelegate.appContainer.networkService
        let tableViewDataHandler = ListCurrencyTableViewDataHandler()
        let presenter = ListCurrencyPresenter(dependencies: .init(model: model,
                                                                  router: router,
                                                                  networkService: networkService,
                                                                  tableViewDataHandler: tableViewDataHandler))
        let controller = ListCurrencyController(dependencies: .init(presenter: presenter))
        return controller
    }
}

