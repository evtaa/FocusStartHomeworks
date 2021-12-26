//
//  AuthController.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import UIKit

protocol IAuthController: UIViewController, ShowAlert {
    func configure()
    func showErrorCoreData(stringError: String)
    func showErrorAuth()
    func goToConverter()
}

final class AuthController: UIViewController {

    // MARK: Properties
    private let presenter: IAuthPresenter
    private var rootView: IAuthView {
        view as? IAuthView ?? AuthView()
    }
    
    // MARK: Structures
    struct Dependencies {
        let presenter: IAuthPresenter
    }
    
    // MARK: Init
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycles
    override func loadView() {
        let newView: IAuthView = AuthView()
        view = newView
        presenter.loadView(view: rootView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: IAuthController
extension AuthController: IAuthController {
    func configure() {
    }
    
    func showErrorCoreData(stringError: String) {
        showError(forViewController: self, withMessage: AppText.Auth.showErrorCoreData + stringError)
    }
    
    func showErrorAuth() {
        showError(forViewController: self, withMessage: AppText.Auth.showErrorAuth)
    }
    
    // MARK: - Navigation
    func goToConverter() {
//        let vc = MainAssembler.assemble()
//        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow == true}.last
//        keyWindow?.rootViewController = vc
    }
}

