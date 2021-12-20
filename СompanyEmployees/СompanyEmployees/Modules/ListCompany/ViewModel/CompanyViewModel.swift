//
//  CompanyViewModel.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import Foundation
protocol ICompanyViewModel {
    var name: String { get }
}

struct CompanyViewModel {
   var name: String
}

extension CompanyViewModel: ICompanyViewModel {
}
