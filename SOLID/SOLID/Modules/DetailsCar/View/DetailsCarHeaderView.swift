//
//  DetailsCarHeaderView.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import UIKit
protocol IDetailsCarHeaderView: UITableViewHeaderFooterView {
}

class DetailsCarHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = AppText.DetailsCar.Cell.headerOfTable
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
                                            constant: AppLayout.DetailsCar.HeaderCell.topTitleLabel),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                constant: AppLayout.DetailsCar.HeaderCell.leadingTitleLabel),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                 constant: AppLayout.DetailsCar.HeaderCell.trailingTitleLabel),
            titleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                               constant: AppLayout.DetailsCar.HeaderCell.bottomTitleLabel),
        ])
    }
}

// MARK: - IDetailsCarHeaderView
extension DetailsCarHeaderView: IDetailsCarHeaderView {
    
}
