//
//  ListCarsHeaderView.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 05.12.2021.
//

import UIKit
protocol IListCarsHeaderView: UITableViewHeaderFooterView {
}

class ListCarsHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = AppText.ListCars.Cell.headerOfTable
        label.font = AppFonts.bigSystem
        label.textAlignment = .left
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configureUI() {
        contentView.backgroundColor =  AppColors.backgroundColor
        configureLayoutContentView()
    }
    
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                            constant: AppLayout.ListCars.HeaderCell.topTitleLabel),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                constant: AppLayout.ListCars.HeaderCell.leadingTitleLabel),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                 constant: AppLayout.ListCars.HeaderCell.trailingTitleLabel),
            titleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                               constant: AppLayout.ListCars.HeaderCell.bottomTitleLabel),
        ])
    }
}

// MARK: - IListCarsHeaderView
extension ListCarsHeaderView: IListCarsHeaderView {
    
}
