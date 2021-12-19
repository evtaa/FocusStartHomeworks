//
//  CompanyModel.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import Foundation

final class CompanyModel {
    let uid: UUID
    private(set) var name: String
    
    init(name: String) {
        self.uid = UUID()
        self.name = name
    }
    
    init(company: Company) {
        self.uid = company.uid
        self.name = company.name
    }
}
