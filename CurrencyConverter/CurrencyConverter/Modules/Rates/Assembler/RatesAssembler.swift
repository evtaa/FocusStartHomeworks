//
//  RatesAssembler.swift
// f CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import UIKit

final class RatesAssembler {
    static func assemble(infoForRates: InfoForRates) -> RatesController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        { return nil }
        let router = RatesRouter()
        let model = RatesModel()
        let networkService = appDelegate.appContainer.networkService
        let tableViewDataHandler = RatesTableViewDataHandler()
        let presenter = RatesPresenter(dependencies: .init(model: model,
                                                           router: router,
                                                           networkService: networkService,
                                                           tableViewDataHandler: tableViewDataHandler,
                                                           infoForRates: infoForRates))
        let controller = RatesController(dependencies: .init(presenter: presenter))
        return controller
    }
}
