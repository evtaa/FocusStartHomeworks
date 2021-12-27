//
//  ListImagesView.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListImagesView: UIView {
    func setTableViewDataSource(object : UITableViewDataSource)
    func setTableViewDelegate(object : UITableViewDelegate)
    func registerTableViewCell (_ cellType: UITableViewCell.Type)
    func registerTableViewHeaderCell (_ cellType: UITableViewHeaderFooterView.Type)
    func reloadData()
    func getIndexPathFromCell(_ cell: ListImagesCell) -> IndexPath?
    func reloadRow(_ row: Int)
}

class ListImagesView: UIView {
    
    // MARK: SubViews
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = AppLayout.ListImages.tableRowHeight
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
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.ListImages.topTableView),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.ListImages.leadingTableView),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.ListImages.trailingTableView),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: AppLayout.ListImages.bottomTableView)
        ])
    }
}

// MARK: - IListCarsView
extension ListImagesView: IListImagesView {
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
    
    func getIndexPathFromCell(_ cell: ListImagesCell) -> IndexPath? {
        let indexPath = tableView.indexPath(for: cell)
        return indexPath
    }
    
    func reloadRow(_ row: Int) {
        tableView.beginUpdates()
        if tableView.cellForRow(at: IndexPath(row: row, section: 0)) != nil {
            tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
        }
        tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .none)
        tableView.endUpdates()
    }
}
