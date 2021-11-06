//
//  ListCarsView.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import UIKit

class ListCarsView: UIView {
    
    // MARK: - Subview
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tableView, addButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = AppLayout.ListCars.tableEstimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.isHidden = false
        return tableView
    }()
    
    private(set) var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        configureStackView()
    }
    
    private func configureAddButton() {
        NSLayoutConstraint.activate(
            [addButton.heightAnchor.constraint(equalToConstant: AppLayout.ListCars.heightAddButton)])
    }
    
    private func configureStackView() {
        addSubview(stackView)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 19.0),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.ListCars.leadingStackView),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.ListCars.trailingStackView),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: -AppLayout.ListCars.indentFromBottomAddButton)
        ])
    }
    
}
