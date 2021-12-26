//
//  RatesController.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import UIKit

protocol IRatesController: UIViewController, ShowAlert {
    func configure()
    func showErrorInternet(stringError: String)
}

class RatesController: UIViewController {

    // MARK: Properties
    private let presenter: IRatesPresenter
    private var rootView: IRatesView {
        view as? IRatesView ?? RatesView()
    }
    
    // MARK: Structures
    struct Dependencies {
        let presenter: IRatesPresenter
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
        let newView: IRatesView = RatesView()
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
        title = AppText.Rates.title
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
    }
}

// MARK: IRatesController
extension RatesController: IRatesController {
    func configure() {
    }
    
    func showErrorInternet(stringError: String) {
        showError(forViewController: self, withMessage: AppText.Converter.showErrorInternet + stringError)
    }
}

