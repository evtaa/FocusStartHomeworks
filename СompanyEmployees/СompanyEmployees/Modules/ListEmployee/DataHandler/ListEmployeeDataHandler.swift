//
//  ListEmployeeDataHandler.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import UIKit

protocol IListEmployeeTableViewDataHandler: UITableViewDataSource, UITableViewDelegate {
    var didSelectRowDataHandler: ((_ employee: EmployeeModel) -> Void)? { get set }
    var trailingSwipeActionsRowDataHandler: ((_ company: EmployeeModel) -> Void)? { get set }
    
    func setEmployees(employees: [EmployeeModel])
}

final class ListEmployeeTableViewDataHandler: NSObject {
    
    // MARK: - Handlers
    var didSelectRowDataHandler: ((_ employee: EmployeeModel) -> Void)?
    var trailingSwipeActionsRowDataHandler: ((_ company: EmployeeModel) -> Void)?
    
    //MARK: - Properties
    private var employees: [EmployeeModel]?
}

// MARK: - UITableViewDataSource
extension ListEmployeeTableViewDataHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count =  employees?.count
        else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let employee = employees?[indexPath.row],
              let employeeViewModel = EmployeeViewModelFactory.create(from: employee)
        else { return ListEmployeeCell() }
        let cell = tableView.dequeueReusableCell(ofType: ListEmployeeCell.self, for: indexPath) as IListEmployeeCell
        cell.configure(with: employeeViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListEmployeeTableViewDataHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let employee = employees?[indexPath.row]
        else { return }
        didSelectRowDataHandler?(employee)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let employee = employees?[indexPath.row]
        else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: AppText.delete, handler: { [weak self] (_, _, _) in
            self?.trailingSwipeActionsRowDataHandler?(employee)
        })
        deleteAction.backgroundColor = AppColors.deleteColor
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - IListEmployeeTableViewDataHandler
extension ListEmployeeTableViewDataHandler: IListEmployeeTableViewDataHandler{
    func setEmployees(employees: [EmployeeModel]) {
        self.employees = employees
    }
}
