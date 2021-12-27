//
//  ListCompanyCell.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import UIKit

protocol IListCompanyCell: UITableViewCell  {
    func configure(with model: ICompanyViewModel)
}

final class ListCompanyCell: UITableViewCell {

    private let nameCompanyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayoutContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        nameCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameCompanyLabel)
        NSLayoutConstraint.activate([
            
            nameCompanyLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                  constant: AppLayout.ListCompany.Cell.topNameCompanyLabel),
            nameCompanyLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.ListCompany.Cell.leadingNameCompanyLabel),
            nameCompanyLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                       constant: AppLayout.ListCompany.Cell.trailingNameCompanyLabel),
            nameCompanyLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                     constant: AppLayout.ListCompany.Cell.bottomTopNameCompanyLabel),
        ])
    }
}

// MARK: - IListCompanyView
extension ListCompanyCell: IListCompanyCell {
    func configure(with model: ICompanyViewModel) {
        nameCompanyLabel.text = model.name
    }
}
