//
//  AddCompanyPresenter.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import Foundation

protocol IAddCompanyPresenter {
    func loadView(view: IAddCompanyView, controller: IAddCompanyController)
}

final class AddCompanyPresenter {
    
    // MARK: - Properties
    private let model: IAddCompanyModel
    private var router: IAddCompanyRouter
    private let companyStorage: ICompanyStorage
    private weak var view: IAddCompanyView?
    private weak var controller: IAddCompanyController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IAddCompanyModel
        let router: IAddCompanyRouter
        let companyStorage: ICompanyStorage
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.companyStorage = dependencies.companyStorage
    }
    
    // MARK: - Actions
    private func setHandlers() {
        controller?.touchDoneTouchUpInsideHandler = { [weak self] in
            self?.saveCompany()
        }
        
        router.backToListCompanyHandler = { [weak self] in
            self?.controller?.backToListCompany()
        }
    }
    
    // MARK: - Private functions
    private func saveCompany() {
        guard let nameOfCompany = view?.getNameOfCompany(),
              nameOfCompany.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            controller?.showFailedNameOfCompany()
            return
        }
        let company = CompanyModel(name: nameOfCompany)
        companyStorage.save(company: company, completion: { [weak self] error in
            if let error = error {
                self?.controller?.showAlert(error: error)
                return
            }
            self?.router.backToListCompany()
        })
    }
}

// MARK: - IPresenter
extension AddCompanyPresenter: IAddCompanyPresenter {
    func loadView(view: IAddCompanyView, controller: IAddCompanyController) {
        self.view = view
        self.controller = controller
        controller.configure()
        setHandlers()
    }
}


