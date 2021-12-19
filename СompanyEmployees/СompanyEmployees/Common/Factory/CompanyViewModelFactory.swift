//
//  CompanyViewModelFactory.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import Foundation

final class CompanyViewModelFactory {
    static func create(from company: CompanyModel) -> ICompanyViewModel? {
        let name = company.name
        return CompanyViewModel(name: name)
    }
}
