//
//  AddEmployeeModel.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IAddEmployeeModel {
    var company: CompanyModel? { get set }
    
    func getCompany() -> CompanyModel?
    func setCompany(company: CompanyModel)
}

final class AddEmployeeModel {
    var company: CompanyModel?

}

// MARK: - IAddCarsModel
extension AddEmployeeModel: IAddEmployeeModel{
    func getCompany() -> CompanyModel? {
        guard let company = self.company
        else { return nil}
        return company
    }
    
    func setCompany(company: CompanyModel) {
        self.company = company
    }
}
