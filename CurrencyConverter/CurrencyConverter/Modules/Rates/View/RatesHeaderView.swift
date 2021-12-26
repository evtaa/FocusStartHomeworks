//
//  RatesHeaderView.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import UIKit

protocol IRatesHeaderView: UITableViewHeaderFooterView {
}

final class RatesHeaderView: UITableViewHeaderFooterView {

    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.bigSystemBold
        label.textAlignment = .left
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
                                            constant: AppLayout.Rates.HeaderCell.topTitleLabel),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                constant: AppLayout.Rates.HeaderCell.leadingTitleLabel),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                 constant: AppLayout.Rates.HeaderCell.trailingTitleLabel),
            titleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                               constant: AppLayout.Rates.HeaderCell.bottomTitleLabel),
        ])
    }
    
    func configure (with viewModel: IRatesBaseRateViewModel) {
        titleLabel.text = viewModel.baseCurrency
    }
}
