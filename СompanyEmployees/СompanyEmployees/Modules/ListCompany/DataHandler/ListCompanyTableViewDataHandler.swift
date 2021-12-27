//
//  ListImagesDataHandler.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListCompanyTableViewDataHandler: UITableViewDataSource, UITableViewDelegate {
    var didSelectRowDataHandler: ((_ company: CompanyModel) -> Void)? { get set }
    var trailingSwipeActionsRowDataHandler: ((_ company: CompanyModel) -> Void)? { get set }
    
    func setCompanies(companies: [CompanyModel])
}

final class ListCompanyTableViewDataHandler: NSObject {
    
    // MARK: - Handlers
    var didSelectRowDataHandler: ((_ company: CompanyModel) -> Void)?
    var trailingSwipeActionsRowDataHandler: ((_ company: CompanyModel) -> Void)?
    
    //MARK: - Properties
    private var companies: [CompanyModel]?
}

// MARK: - UITableViewDataSource
extension ListCompanyTableViewDataHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count =  companies?.count
        else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let company = companies?[indexPath.row],
              let viewModel = CompanyViewModelFactory.create(from: company)
        else { return ListCompanyCell()}
        let cell = tableView.dequeueReusableCell(ofType: ListCompanyCell.self, for: indexPath) as IListCompanyCell
        cell.configure(with: viewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListCompanyTableViewDataHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let company = companies?[indexPath.row]
        else { return }
        didSelectRowDataHandler?(company)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let company = companies?[indexPath.row]
        else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: AppText.delete, handler: { [weak self] (_, _, _) in
            self?.trailingSwipeActionsRowDataHandler?(company)
        })
        deleteAction.backgroundColor = AppColors.deleteColor
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}



// MARK: - IListCompanyTableViewDataHandler
extension ListCompanyTableViewDataHandler: IListCompanyTableViewDataHandler{
    func setCompanies(companies: [CompanyModel]) {
        self.companies = companies
    }
}
