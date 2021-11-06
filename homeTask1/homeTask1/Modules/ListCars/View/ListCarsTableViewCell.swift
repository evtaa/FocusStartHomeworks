//
//  ListCarsTableViewCell.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import UIKit

class ListCarsTableViewCell: UITableViewCell {

    // MARK: - Subviews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [manufacturerLabel,
                                                       modelLabel,
                                                       bodyLabel,
                                                       yearOfIssueLabel,
                                                       carNumberLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let manufacturerLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        return label
    } ()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        return label
    } ()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        return label
    } ()
    
    private let yearOfIssueLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        return label
    } ()
    
    private let carNumberLabel: UILabel = {
        let label = UILabel()
        label.setForParametersOfCar()
        return label
    } ()
    
    // MARK: - Initialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func configure(with car: CarViewModel) {
        manufacturerLabel.text = car.manufacturer
        modelLabel.text = car.model
        bodyLabel.text = car.body
        yearOfIssueLabel.text = car.yearOfIssue
        if let carNumber = car.carNumber {
            carNumberLabel.text = carNumber
        } else {
            carNumberLabel.isHidden = true
        }
        
    }
    
    // MARK: - ConfigureUI
    private func configureUI () {
        configureMainStackView()
    }
    
    private func configureMainStackView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                constant: AppLayout.ListCarsTableViewCell.topCarCellView),
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                    constant: AppLayout.ListCarsTableViewCell.leadingCarCellView),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                     constant: AppLayout.ListCarsTableViewCell.trailingCarCellView),
             mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                   constant: AppLayout.ListCarsTableViewCell.bottomCarCellView)
            ])
    }
}
