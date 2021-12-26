//
//  ConverterAssemble.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

final class ConverterAssembler {
    static func assemble() -> ConverterController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        { return nil }
        let router = ConverterRouter()
        let model = ConverterModel()
        let networkService = appDelegate.appContainer.networkService
        let pasteboardService = appDelegate.appContainer.pasteboardService
        
        let pickerViewDataHandler = ConverterPickerViewDataHandler()
        let textFieldDataHandler = ConverterTextFieldDataHandler()
        let presenter = ConverterPresenter(dependencies: .init(model: model,
                                                               router: router,
                                                               networkService: networkService,
                                                               pasteboardService: pasteboardService,
                                                               textFieldDataHandler: textFieldDataHandler,
                                                               pickerViewDataHandler: pickerViewDataHandler))
        let controller = ConverterController(dependencies: .init(presenter: presenter))
        return controller
    }
}
