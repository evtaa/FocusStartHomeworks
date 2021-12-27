//
//  ListCompanyController.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListCompanyController: UIViewController {
    func configure()
    func goToAddCompany(companyStorage: ICompanyStorage)
    func goToListEmployee(employeeStorage: IEmployeeStorage, company: CompanyModel)
    func showAlert(error: Error)
}

final class ListCompanyController: UIViewController, ShowAlert {

    // MARK: Properties
    private let presenter: IListCompanyPresenter
    private var rootView: IListCompanyView {
        view as? IListCompanyView ?? ListCompanyView()
    }
    
    // MARK: Structures
    struct Dependencies {
        let presenter: IListCompanyPresenter
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
        let listCompanyView: IListCompanyView = ListCompanyView()
        view = listCompanyView
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
        title = AppText.titleListCompany
    }
}

// MARK: IListCompanyController
extension ListCompanyController: IListCompanyController {
    
    // MARK: - Configure
    func configure() {
    }
    
    // MARK: - Navigation
    func goToAddCompany(companyStorage: ICompanyStorage) {
        let vc = AddCompanyAssembler.assemble(companyStorage: companyStorage)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToListEmployee(employeeStorage: IEmployeeStorage, company: CompanyModel) {
        let vc = ListEmployeeAssembler.assemble(employeeStorage: employeeStorage, company: company)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(error: Error) {
        showError(forViewController: self, withMessage: AppText.alertOfCoreData + ": " + error.localizedDescription)
    }
}
