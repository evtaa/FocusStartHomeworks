//
//  EditEmployeePresenter.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IEditEmployeePresenter {
    func loadView(view: IEditEmployeeView, controller: IEditEmployeeController)
}

final class EditEmployeePresenter {
    
    // MARK: - Properties
    private let model: IEditEmployeeModel
    private var router: IEditEmployeeRouter
    private var employeeStorage: IEmployeeStorage
    private var employee: EmployeeModel
    private weak var view: IEditEmployeeView?
    private weak var controller: IEditEmployeeController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IEditEmployeeModel
        let router: IEditEmployeeRouter
        let employeeStorage: IEmployeeStorage
        let employee: EmployeeModel
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.employeeStorage = dependencies.employeeStorage
        self.employee = dependencies.employee
    }
    
    // MARK: - Actions
    private func setHandlers() {
        controller?.touchDoneTouchUpInsideHandler = { [weak self] in
            guard let employee = self?.model.getEmployee()
            else { return }
            self?.updateEmployee(employee: employee)
  
        }
        
        router.backToListEmployeeHandler = { [weak self] in
            self?.controller?.backToListEmployee()
        }
    }
    // MARK: - Private functions
    private func updateEmployee(employee: EmployeeModel) {
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
        employee.update(name: nameOfEmployee,
                        age: ageOfEmployeeInt,
                        experience: experienceOfEmployeeInt)
        employeeStorage.update(employee: employee) { [weak self] error in
            if let error = error {
                self?.controller?.showAlert(error: error)
                return
            }
            self?.router.backToListEmployee()
        }
    }
}

// MARK: - IPresenter
extension EditEmployeePresenter: IEditEmployeePresenter {
    func loadView(view: IEditEmployeeView, controller: IEditEmployeeController) {
        self.view = view
        self.controller = controller
        controller.configure()
        model.setEmployee(employee: employee)
        guard let employee = model.getEmployee(),
              let viewModelCompany = EmployeeViewModelFactory.create(from: employee)
        else { return }
        view.configure(with: viewModelCompany)
        setHandlers()
    }
}



