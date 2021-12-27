//
//  RatesCell.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

import UIKit

protocol IRatesCell: UITableViewCell {
    func configure (with viewModel: IRatesRateViewModel)
}

final class RatesCell: UITableViewCell {

    // MARK: - Subviews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionOfCurrencyLabel,
                                                       rateAndCodeOfCurrencyLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = AppLayout.Rates.Cell.spacingMainStackView
        return stackView
    }()
    
    private let descriptionOfCurrencyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.system
        label.textAlignment = .left
        return label
    }()
    
    private let rateAndCodeOfCurrencyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.system
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayoutContentView()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.Rates.Cell.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.Rates.Cell.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                    constant: AppLayout.Rates.Cell.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                  constant: AppLayout.Rates.Cell.bottomMainStackView),
        ])
    }
}

// MARK:  - IListCarsCell
extension RatesCell: IRatesCell {
    func configure (with viewModel: IRatesRateViewModel) {
        descriptionOfCurrencyLabel.text = viewModel.description
        rateAndCodeOfCurrencyLabel.text = viewModel.rateAndCode
    }
}
