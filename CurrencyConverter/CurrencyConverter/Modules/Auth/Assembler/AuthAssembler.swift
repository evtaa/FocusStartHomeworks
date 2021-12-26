//
//  AuthAssembler.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import UIKit

final class AuthAssembler {
    static func assemble() -> AuthController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        { return nil }
        let router = AuthRouter()
        let model = AuthModel()
        let textFieldDataHandler = AuthTextFieldDataHandler()
        let userStorage = appDelegate.appContainer.coreDataService
        let presenter = AuthPresenter(dependencies: .init(model: model,
                                                          router: router,
                                                          textFieldDataHandler: textFieldDataHandler,
                                                          userStorage: userStorage))
        let controller = AuthController(dependencies: .init(presenter: presenter))
        return controller
    }
}
