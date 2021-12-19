//
//  AddEmployeePresenter.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IAddEmployeePresenter {
    func loadView(view: IAddEmployeeView, controller: IAddEmployeeController)
}

final class AddEmployeePresenter {
    
    // MARK: - Properties
    private let model: IAddEmployeeModel
    private var router: IAddEmployeeRouter
    private var employeeStorage: IEmployeeStorage
    private var company: CompanyModel
    private weak var view: IAddEmployeeView?
    private weak var controller: IAddEmployeeController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IAddEmployeeModel
        let router: IAddEmployeeRouter
        let employeeStorage: IEmployeeStorage
        let company: CompanyModel
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.company = dependencies.company
        self.employeeStorage = dependencies.employeeStorage
    }
    
    // MARK: - Actions
    private func setHandlers() {
        controller?.touchDoneTouchUpInsideHandler = { [weak self] in
            self?.saveEmployee()
        }
        
        router.backToListEmployeeHandler = { [weak self] in
            self?.controller?.backToListEmployee()
        }
    }
    // MARK: - Private functions
    private func saveEmployee() {
        guard let nameOfEmployee = view?.getNameOfEmployee(),
              nameOfEmployee.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            controller?.showFailedNameOfEmployee()
            return
        }
        
        guard let ageOfEmployee = view?.getAgeOfEmployee(),
              ageOfEmployee.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false,
              let ageOfEmployeeInt = Int(ageOfEmployee)  else {
            controller?.showFailedAgeOfEmployee()
            return
        }
        var experienceOfEmployeeInt: Int?
        if let experienceOfEmployee = view?.getExperienceOfEmployee(),
           experienceOfEmployee.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            guard Int(experienceOfEmployee) != nil else {
                controller?.showFailedExperienceOfEmployee()
                return
            }
            experienceOfEmployeeInt = Int(experienceOfEmployee)
        } else {
            experienceOfEmployeeInt = nil
        }
        guard let company = model.getCompany()
        else { return }
        let employee = EmployeeModel(companyUid: company.uid,
                                     name: nameOfEmployee,
                                         age: ageOfEmployeeInt,
                                         experience: experienceOfEmployeeInt)
        employeeStorage.save(employee: employee) { [weak self] error in
                if let error = error {
                    self?.controller?.showAlert(error: error)
                    return
                }
                self?.router.backToListEmployee()
            }
        }
    }
    
    // MARK: - IPresenter
    extension AddEmployeePresenter: IAddEmployeePresenter {
        func loadView(view: IAddEmployeeView, controller: IAddEmployeeController) {
            self.view = view
            self.controller = controller
            controller.configure()
            model.setCompany(company: company)
            setHandlers()
        }
    }


