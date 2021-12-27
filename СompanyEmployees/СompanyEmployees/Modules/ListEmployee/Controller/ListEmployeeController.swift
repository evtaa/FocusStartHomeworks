//
//  ListEmployeeController.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import UIKit

import UIKit

protocol IListEmployeeController: UIViewController {
    func configure()
    func goToAddEmployee(employeeStorage: IEmployeeStorage,
                         company: CompanyModel)
    func goToEditEmployee(employeeStorage: IEmployeeStorage,
                          employee: EmployeeModel)
    func showAlert(error: Error)
}

class ListEmployeeController: UIViewController, ShowAlert {

    // MARK: Properties
    private let presenter: IListEmployeePresenter
    private var rootView: IListEmployeeView {
        view as? IListEmployeeView ?? ListEmployeeView()
    }
    
    // MARK: Structures
    struct Dependencies {
        let presenter: IListEmployeePresenter
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
        let listEmployeeView: IListEmployeeView = ListEmployeeView()
        view = listEmployeeView
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
        title = AppText.titleListEmployee
    }
}

// MARK: IListEmployeeController
extension ListEmployeeController: IListEmployeeController {
    
    // MARK: - Configure
    func configure() {
    }
    
    // MARK: - Navigation
    func goToAddEmployee(employeeStorage: IEmployeeStorage,
                         company: CompanyModel) {
        let vc = AddEmployeeAssembler.assemble(employeeStorage: employeeStorage,
                                               company: company)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEditEmployee(employeeStorage: IEmployeeStorage,
                          employee: EmployeeModel) {
        let vc = EditEmployeeAssembler.assemble(employeeStorage: employeeStorage,
                                                employee: employee)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(error: Error) {
        showError(forViewController: self, withMessage: AppText.alertOfCoreData + ": " + error.localizedDescription)
    }
}

