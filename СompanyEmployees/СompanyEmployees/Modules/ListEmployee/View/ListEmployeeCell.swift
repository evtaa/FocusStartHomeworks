//
//  ListEmployeeCell.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import UIKit

protocol IListEmployeeCell: UITableViewCell  {
    func configure(with model: IEmployeeViewModel)
}

final class ListEmployeeCell: UITableViewCell {

    // MARK: - Subviews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameEmployeeIsLabel,nameEmployeeLabel,
                                                       ageEmployeeIsLabel, ageEmployeeLabel,
                                                       experienceEmployeeIsLabel, experienceEmployeeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.ListEmployee.spacingMainStackView
        return stackView
    }()
    
    private let nameEmployeeIsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = AppText.nameOfEmployeeIs
        label.font = AppFont.systemBold
        return label
    }()
    
    private let nameEmployeeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let ageEmployeeIsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = AppText.ageOfEmployeeIs
        label.font = AppFont.systemBold
        return label
    }()
    
    private let ageEmployeeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let experienceEmployeeIsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = AppText.experienceOfEmployeeIs
        label.font = AppFont.systemBold
        return label
    }()
    
    private let experienceEmployeeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                  constant: AppLayout.ListEmployee.Cell.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.ListEmployee.Cell.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                       constant: AppLayout.ListEmployee.Cell.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                     constant: AppLayout.ListEmployee.Cell.bottomMainStackView),
        ])
    }
}

// MARK: - IListEmployeeView
extension ListEmployeeCell: IListEmployeeCell {
    func configure(with model: IEmployeeViewModel) {
        nameEmployeeLabel.text = model.name
        ageEmployeeLabel.text = model.age
        if model.experience == "0" {
            experienceEmployeeLabel.isHidden = true
            experienceEmployeeIsLabel.isHidden = true
        } else {
            experienceEmployeeLabel.isHidden = false
            experienceEmployeeIsLabel.isHidden = false
            experienceEmployeeLabel.text = model.experience
        }
    }
}
