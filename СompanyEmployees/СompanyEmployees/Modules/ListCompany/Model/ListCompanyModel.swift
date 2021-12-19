//
//  ListCompanyModel.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import Foundation

protocol IListCompanyModel {
    var companies: [CompanyModel]? { get set }
    
    func getCompanies() -> [CompanyModel]?
    func setCompanies(companies: [CompanyModel])
}

final class ListCompanyModel {
    var companies: [CompanyModel]?

}

// MARK: - IListCompanyModel
extension ListCompanyModel: IListCompanyModel{
    func getCompanies() -> [CompanyModel]? {
        guard let companies = self.companies
        else { return nil}
        return companies
    }
    
    func setCompanies(companies: [CompanyModel]) {
        self.companies = companies
    }
}
