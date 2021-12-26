//
//  ListCurrencyController.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import UIKit

protocol IListCurrencyController: UIViewController, ShowAlert {
    var backToAuthHandler: (() -> Void)? { get set }
    
    func configure()
    func showErrorInternet(stringError: String)
    func goToAuth()
    func goToRates(infoForRates: InfoForRates)
}

final class ListCurrencyController: UIViewController {

    // MARK: Properties
    private let presenter: IListCurrencyPresenter
    private var rootView: IListCurrencyView {
        view as? IListCurrencyView ?? ListCurrencyView()
    }
    
    // MARK: - Handlers
    var backToAuthHandler: (() -> Void)?
    
    // MARK: Structures
    struct Dependencies {
        let presenter: IListCurrencyPresenter
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
        let newView: IListCurrencyView = ListCurrencyView()
        view = newView
        presenter.loadView(view: rootView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureNavigationBar()
    }
    
    // MARK: Configure
    private func configureNavigationBar() {
        title = AppText.ListCurrency.title
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        let backButton = UIBarButtonItem(title: AppText.logout,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backToAuth))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = backButton
    }
    
    // MARK: - Actions
    @objc private func backToAuth() {
        backToAuthHandler?()
    }
}

// MARK: IListCurrencyController
extension ListCurrencyController: IListCurrencyController {
    func configure() {
    }
    
    func showErrorInternet(stringError: String) {
        showError(forViewController: self, withMessage: AppText.Converter.showErrorInternet + stringError)
    }
    
    // MARK: - Navigation
    func goToAuth() {
        let vc = AuthAssembler.assemble()
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow == true}.last
        keyWindow?.rootViewController = vc
    }
    
    func goToRates(infoForRates: InfoForRates) {
        guard let vc = RatesAssembler.assemble(infoForRates: infoForRates)
        else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
}

