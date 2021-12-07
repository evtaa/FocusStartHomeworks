//
//  ListCarsView.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import UIKit

protocol IListCarsView: UIView {
    func setTableViewDataSource(object : UITableViewDataSource)
    func setTableViewDelegate(object : UITableViewDelegate)
    func registerTableViewCell (_ cellType: UITableViewCell.Type)
    func registerTableViewHeaderCell (_ cellType: UITableViewHeaderFooterView.Type)
    func reloadData()
}

final class ListCarsView: UIView {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = AppLayout.ListCars.tableEstimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = AppLayout.ListCars.tableEstimatedRowHeight
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayoutView()
        backgroundColor = AppColors.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.ListCars.topTableView),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.ListCars.leadingTableView),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.ListCars.trailingTableView),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: AppLayout.ListCars.bottomTableView)
        ])
    }
}

// MARK: - IListCarsView
extension ListCarsView: IListCarsView {
    func setTableViewDataSource(object : UITableViewDataSource) {
        tableView.dataSource = object
    }
    
    func setTableViewDelegate(object : UITableViewDelegate) {
        tableView.delegate = object
    }
    
    func registerTableViewCell (_ cellType: UITableViewCell.Type) {
        tableView.register(cellType)
    }
    
    func registerTableViewHeaderCell (_ cellType: UITableViewHeaderFooterView.Type) {
        tableView.register(cellType)
    }
    
    func reloadData () {
        tableView.reloadData()
    }
}
