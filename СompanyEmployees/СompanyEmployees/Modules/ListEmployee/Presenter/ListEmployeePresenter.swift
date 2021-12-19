//
//  ListEmployeePresenter.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IListEmployeePresenter {
    func loadView(view: IListEmployeeView, controller: IListEmployeeController)
}

final class ListEmployeePresenter {
    
    // MARK: - Properties
    private let model: IListEmployeeModel
    private var router: IListEmployeeRouter
    private let tableViewDataHandler: IListEmployeeTableViewDataHandler
    private var employeeStorage: IEmployeeStorage
    private let company: CompanyModel
    private weak var view: IListEmployeeView?
    private weak var controller: IListEmployeeController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IListEmployeeModel
        let router: IListEmployeeRouter
        let tableViewDataHandler: IListEmployeeTableViewDataHandler
        let employeeStorage: IEmployeeStorage
        let company: CompanyModel
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.tableViewDataHandler = dependencies.tableViewDataHandler
        self.employeeStorage = dependencies.employeeStorage
        self.company = dependencies.company
    }
    
    // MARK: - Actions
    private func setHandlers() {
        
        employeeStorage.updateEmployees = { [weak self] in
            if let company = self?.model.getCompany() {
                self?.loadEmployeesAndReloadData(company: company)
            }
        }
        
        view?.addButtonTouchUpInsideHandler = { [weak self] in
            self?.router.goToAddEmployee()
        }
        
        router.goToAddEmployeeDataHandler = { [weak self] in
            guard let employeeStorage = self?.employeeStorage,
                  let modelCompany = self?.model.getCompany()
            else { return }
            self?.controller?.goToAddEmployee(employeeStorage: employeeStorage,
                                             company: modelCompany)
        }
        
        tableViewDataHandler.didSelectRowDataHandler = { [weak self] employee in
            self?.router.goToEditEmployee(employee: employee)
        }
        
        router.goToEditEmployeeDataHandler = { [weak self] employee in

        }
        
        tableViewDataHandler.trailingSwipeActionsRowDataHandler = { [weak self] employee in
            self?.removeEmployee(employee: employee)
        }
    }
    
    // MARK: - Private functions
    private func loadEmployeesAndReloadData(company: CompanyModel) {
        employeeStorage.loadEmployees(for: company,
                                      completion: { [weak self] result in
            switch result {
            case .success(let employees):
                self?.model.setEmployees(employees: employees)
                if let modelEmployees = self?.model.getEmployees() {
                    self?.tableViewDataHandler.setEmployees(employees: modelEmployees)
                }
                self?.view?.reloadData()
            case .failure(let error):
                self?.controller?.showAlert(error: error)
            }
        })
    }
    
    private func removeEmployee(employee: EmployeeModel) {
        employeeStorage.remove(employee: employee) { [weak self] error in
            if let error = error {
                self?.controller?.showAlert(error: error)
                return
            }
        }
    }
}

// MARK: - IListEmployeePresenter
extension ListEmployeePresenter: IListEmployeePresenter {
    func loadView(view: IListEmployeeView, controller: IListEmployeeController) {
        self.view = view
        self.controller = controller
        controller.configure()
        view.setTableViewDataSource(object: tableViewDataHandler)
        view.setTableViewDelegate(object: tableViewDataHandler)
        view.registerTableViewCell(ListEmployeeCell.self)
        model.setCompany(company: company)
        if let company = model.getCompany() {
            loadEmployeesAndReloadData(company: company)
        }
        setHandlers()
    }
}

