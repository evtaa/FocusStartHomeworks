//
//  AddCompanyController.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import UIKit

protocol IAddCompanyController: UIViewController  {
    var touchDoneTouchUpInsideHandler: (() -> Void)? { get set }
    
    func configure()
    func backToListCompany()
    func showFailedNameOfCompany()
    func showAlert(error: Error)
}

final class AddCompanyController: UIViewController, ShowAlert {

    // MARK: Properties
    private let presenter: IAddCompanyPresenter
    private var rootView: IAddCompanyView {
        view as? IAddCompanyView ?? AddCompanyView()
    }
    
    // MARK: - Handlers
    var touchDoneTouchUpInsideHandler: (() -> Void)?
    
    // MARK: Structures
    struct Dependencies {
        let presenter: IAddCompanyPresenter
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
        let newView: IAddCompanyView = AddCompanyView()
        view = newView
        presenter.loadView(view: rootView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureNavigationBar()
    }
    
    // MARK: Configure
    private func configureNavigationBar() {
        title = AppText.titleAddCompany
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        
        let backButton = UIBarButtonItem(title: AppText.done,
                                         style: .plain,
                                         target: self,
                                         action: #selector(touchDoneTouchUpInside))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = backButton
    }
    
    // MARK: - Actions
    @objc private func touchDoneTouchUpInside() {
        touchDoneTouchUpInsideHandler?()
    }
}

// MARK: IAddCompanyController
extension AddCompanyController: IAddCompanyController {
    func configure() {
    }
    
    func backToListCompany() {
        navigationController?.popViewController(animated: true)
    }
    
    func showFailedNameOfCompany() {
        showError(forViewController: self, withMessage: AppText.alertNameOfCompany)
    }
    
    func showAlert(error: Error) {
        showError(forViewController: self, withMessage: AppText.alertOfCoreData + ": " + error.localizedDescription)
    }
}
