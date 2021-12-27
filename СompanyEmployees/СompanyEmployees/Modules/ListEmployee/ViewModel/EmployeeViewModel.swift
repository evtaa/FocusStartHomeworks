//
//  EmployeeViewModel.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation
protocol IEmployeeViewModel {
    var name: String { get set }
    var age: String { get set }
    var experience: String? { get set }
}

struct EmployeeViewModel {
    var name: String
    var age: String
    var experience: String?
}

extension EmployeeViewModel: IEmployeeViewModel {
}
