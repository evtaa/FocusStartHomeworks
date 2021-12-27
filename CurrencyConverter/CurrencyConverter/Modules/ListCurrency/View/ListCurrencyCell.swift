//
//  ListCurrencyCell.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import UIKit

protocol IListCurrencyCell: UITableViewCell {
    func configure (with viewModel: IListCurrencySymbolViewModel)
}

final class ListCurrencyCell: UITableViewCell {

    // MARK: - Subviews
    private let nameAndTypeOfCurrencyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.system
        label.textAlignment = .left
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
        nameAndTypeOfCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameAndTypeOfCurrencyLabel)
        NSLayoutConstraint.activate([
            nameAndTypeOfCurrencyLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.ListCurrency.Cell.topNameAndTypeOfCurrencyLabel),
            nameAndTypeOfCurrencyLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.ListCurrency.Cell.leadingNameAndTypeOfCurrencyLabel),
            nameAndTypeOfCurrencyLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                    constant: AppLayout.ListCurrency.Cell.trailingNameAndTypeOfCurrencyLabel),
            nameAndTypeOfCurrencyLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                  constant: AppLayout.ListCurrency.Cell.bottomNameAndTypeOfCurrencyLabel),
        ])
    }
}

// MARK:  - IListCarsCell
extension ListCurrencyCell: IListCurrencyCell {
    func configure (with viewModel: IListCurrencySymbolViewModel) {
        nameAndTypeOfCurrencyLabel.text = viewModel.descriptionAndCode
    }
}
