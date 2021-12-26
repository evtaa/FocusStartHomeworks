//
//  ListCurrencyHeaderView.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import UIKit

protocol IListCurrencyHeaderView: UITableViewHeaderFooterView {
}

final class ListCurrencyHeaderView: UITableViewHeaderFooterView {

    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = AppText.ListCurrency.HeaderCell.headerOfTable
        label.font = AppFont.bigSystemBold
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayoutContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configureUI() {
        contentView.backgroundColor =  AppColors.backgroundColor
    }
    
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                            constant: AppLayout.ListCurrency.HeaderCell.topTitleLabel),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                constant: AppLayout.ListCurrency.HeaderCell.leadingTitleLabel),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                 constant: AppLayout.ListCurrency.HeaderCell.trailingTitleLabel),
            titleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                               constant: AppLayout.ListCurrency.HeaderCell.bottomTitleLabel),
        ])
    }
}
