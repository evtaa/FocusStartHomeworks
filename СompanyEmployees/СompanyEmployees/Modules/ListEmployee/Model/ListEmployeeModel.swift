//
//  ListEmployeeModel.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IListEmployeeModel {
    var company: CompanyModel? { get set }
    var employees: [EmployeeModel]? { get set }
    
    func getCompany() -> CompanyModel?
    func setCompany(company: CompanyModel)
    func getEmployees() -> [EmployeeModel]?
    func setEmployees(employees: [EmployeeModel])
}

final class ListEmployeeModel {
    var company: CompanyModel?
    var employees: [EmployeeModel]?

}

// MARK: - IListCarsModel
extension ListEmployeeModel: IListEmployeeModel{
    func getCompany() -> CompanyModel? {
        guard let company = self.company
        else { return nil}
        return company
    }
    
    func setCompany(company: CompanyModel) {
        self.company = company
    }
    
    func getEmployees() -> [EmployeeModel]? {
        guard let employees = self.employees
        else { return nil}
        return employees
    }
    
    func setEmployees(employees: [EmployeeModel]) {
        self.employees = employees
    }
}

