//
//  RatesView.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import UIKit

protocol IRatesView: UIView {
    var rootViewTapGestureRecognizerHandler: (() -> Void)? { get set }
    
    func endEditingView()
    func setTableViewDelegates(object : UITableViewDataSource & UITableViewDelegate)
    func registerTableViewCell (_ cellType: UITableViewCell.Type)
    func registerTableViewHeaderCell (_ cellType: UITableViewHeaderFooterView.Type)
    func reloadData ()
}

final class RatesView: UIView {
    
    //MARK: - Handlers
    var rootViewTapGestureRecognizerHandler: (() -> Void)?
    
    // MARK: SubViews
    private lazy var tapRootView: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.cancelsTouchesInView = false
        recognizer.addTarget(self, action: #selector(rootViewTapGestureRecognizer))
        return recognizer
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = AppLayout.ListCurrency.tableEstimatedRowHeight
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayoutView()
        configureGestureRecognizer()
        backgroundColor = AppColors.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    @objc private func rootViewTapGestureRecognizer() {
        rootViewTapGestureRecognizerHandler?()
    }
    
    // MARK: - Configure
    private func configureGestureRecognizer() {
        addGestureRecognizer(tapRootView)
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.Rates.topTableView),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.Rates.leadingTableView),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.Rates.trailingTableView),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: AppLayout.Rates.bottomTableView)
        ])
    }
}

// MARK: - IRatesView
extension RatesView: IRatesView {
    func endEditingView() {
        endEditing(true)
    }
    
    func setTableViewDelegates(object : UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = object
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
