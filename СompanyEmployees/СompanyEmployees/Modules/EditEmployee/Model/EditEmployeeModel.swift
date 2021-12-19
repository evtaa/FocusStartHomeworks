//
//  EditEmployeeModel.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

protocol IEditEmployeeModel {
    var employee: EmployeeModel? { get set }
    
    func getEmployee() -> EmployeeModel?
    func setEmployee(employee: EmployeeModel)
}

final class EditEmployeeModel {
    var employee: EmployeeModel?

}

// MARK: - IEditCarsModel
extension EditEmployeeModel: IEditEmployeeModel{
    func getEmployee() -> EmployeeModel? {
        guard let employee = self.employee
        else { return nil}
        return employee
    }
    
    func setEmployee(employee: EmployeeModel) {
        self.employee = employee
    }
}
