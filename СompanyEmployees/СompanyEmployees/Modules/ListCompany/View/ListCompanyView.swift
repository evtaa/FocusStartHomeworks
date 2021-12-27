//
//  View.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListCompanyView: UIView {
    var addButtonTouchUpInsideHandler: (() -> Void)? { get set }
    
    func setTableViewDataSource(object : UITableViewDataSource)
    func setTableViewDelegate(object : UITableViewDelegate)
    func registerTableViewCell (_ cellType: UITableViewCell.Type)
    func reloadData()
}

final class ListCompanyView: UIView {
    
    //MARK: - Handlers
    var addButtonTouchUpInsideHandler: (() -> Void)?
    
    // MARK: SubViews
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [tableView, addButton])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 0
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = AppLayout.ListCompany.tableEstimatedRowHeight
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(AppColors.ListCompany.buttonTextColor, for: .normal)
        button.backgroundColor = AppColors.ListCompany.buttonColor
        button.layer.cornerRadius = AppLayout.ListCompany.addButtonCornerRadius
        button.setTitle(AppText.addButton, for: .normal)
        button.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
        return button
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
    
    // MARK: - Private functions
    @objc private func addButtonTouchUpInside() {
        addButtonTouchUpInsideHandler?()
    }
    
    // MARK: - Configure
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: AppLayout.ListCompany.addButtonHeight),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.ListCompany.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.ListCompany.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.ListCompany.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: AppLayout.ListCompany.bottomMainStackView)
        ])
    }
}

// MARK: - IListCompanyView
extension ListCompanyView: IListCompanyView {
    func setTableViewDataSource(object : UITableViewDataSource) {
        tableView.dataSource = object
    }
    
    func setTableViewDelegate(object : UITableViewDelegate) {
        tableView.delegate = object
    }
    
    func registerTableViewCell (_ cellType: UITableViewCell.Type) {
        tableView.register(cellType)
    }
    
    func reloadData () {
        tableView.reloadData()
    }
}
