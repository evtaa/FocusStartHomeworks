//
//  ListCompanyPresenter.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import Foundation

protocol IListCompanyPresenter {
    func loadView(view: IListCompanyView, controller: IListCompanyController)
}

final class ListCompanyPresenter {
    
    // MARK: - Properties
    private let model: IListCompanyModel
    private var router: IListCompanyRouter
    private let tableViewDataHandler: IListCompanyTableViewDataHandler
    private var companyStorage: ICompanyStorage
    private weak var view: IListCompanyView?
    private weak var controller: IListCompanyController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IListCompanyModel
        let router: IListCompanyRouter
        let tableViewDataHandler: IListCompanyTableViewDataHandler
        let companyStorage: ICompanyStorage
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.tableViewDataHandler = dependencies.tableViewDataHandler
        self.companyStorage = dependencies.companyStorage
    }
    
    // MARK: - Actions
    private func setHandlers() {
        
        companyStorage.updateCompanies = { [weak self] in
            self?.loadCompaniesAndReloadData()
        }
        
        view?.addButtonTouchUpInsideHandler = { [weak self] in
            self?.router.goToAddCompany()
        }
        
        router.goToAddCompanyDataHandler = { [weak self] in
            guard let companyStorage = self?.companyStorage
            else { return }
            self?.controller?.goToAddCompany(companyStorage: companyStorage)
        }
        
        tableViewDataHandler.didSelectRowDataHandler = { [weak self] company in
            self?.router.goToListEmployee(company: company)
        }
        
        router.goToListEmployeeDataHandler = { [weak self] company in
            
        }
        
        tableViewDataHandler.trailingSwipeActionsRowDataHandler = { [weak self] company in
            self?.removeCompany(company: company)
        }
    }
    
    // MARK: - Private functions
    private func loadCompaniesAndReloadData() {
        companyStorage.loadCompanies(completion: { [weak self] result in
            switch result {
            case .success(let companies):
                self?.model.setCompanies(companies: companies)
                if let modelCompanies = self?.model.getCompanies() {
                    self?.tableViewDataHandler.setCompanies(companies: modelCompanies)
                }
                self?.view?.reloadData()
            case .failure(let error):
                self?.controller?.showAlert(error: error)
            }
        })
    }
    
    private func removeCompany(company: CompanyModel) {
        companyStorage.remove(company: company, completion: { [weak self] error in
            if let error = error {
                self?.controller?.showAlert(error: error)
                return
            }
        })
    }
}

// MARK: - IListCompanyPresenter
extension ListCompanyPresenter: IListCompanyPresenter {
    func loadView(view: IListCompanyView, controller: IListCompanyController) {
        self.view = view
        self.controller = controller
        controller.configure()
        view.setTableViewDataSource(object: tableViewDataHandler)
        view.setTableViewDelegate(object: tableViewDataHandler)
        view.registerTableViewCell(ListCompanyCell.self)
        loadCompaniesAndReloadData()
        setHandlers()
    }
}

