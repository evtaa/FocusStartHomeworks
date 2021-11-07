//
//  ListCarsView.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import UIKit

class ListCarsView: UIView {
    
    // MARK: - Subview
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tableView, addButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private(set) var typeOfBodyPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        return pickerView
    }()
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = AppLayout.ListCars.tableEstimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.isHidden = false
        return tableView
    }()
    
    private(set) var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle(Text.add, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.isHidden = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    private func configureUI() {
        backgroundColor = UIColor.systemBackground
        configureAddButton()
        configureMainStackView()
    }
    
    private func configureAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [addButton.heightAnchor.constraint(equalToConstant: AppLayout.ListCars.heightAddButton)])
    }
    
    private func configureMainStackView() {
        
        let safeArea = safeAreaLayoutGuide
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 19.0),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.ListCars.leadingStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.ListCars.trailingStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: -AppLayout.ListCars.indentFromBottomAddButton)
        ])
    }
    
}
