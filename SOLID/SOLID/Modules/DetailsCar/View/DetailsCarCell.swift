//
//  DetailsCarCell.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import UIKit

protocol IDetailsCarCell: UITableViewCell {
    var radioButtonTouchUpInsideHandler: ((_ typeOfBody: TypeOfBody) -> Void)? { get set }
    
    func configure (with viewModel: TableDetailsCarViewModel)
    func setTypeOfBody (typeOfBody: TypeOfBody)
}

class DetailsCarCell: UITableViewCell {
    
    // MARK: - Properties
    var typeOfBody: TypeOfBody?
    
    //MARK: - Handlers
    var radioButtonTouchUpInsideHandler: ((_ typeOfBody: TypeOfBody) -> Void)?
    
    // MARK: - Subviews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [typeOfBodyLabel,
                                                       radioButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = AppLayout.DetailsCar.Cell.spacingMainStackView
        return stackView
    }()
    
    private let typeOfBodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.smallSystem
        label.textAlignment = .left
        return label
    }()
    
    private lazy var radioButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = AppLayout.DetailsCar.Cell.radiusRadioButton
        button.addTarget(self, action: #selector(radioButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayoutContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configureEnabledRadioButton(enabledRadioButton: Bool) {
        if enabledRadioButton {
            radioButton.setImage(AppImages.radioButtonEnabled, for: .normal)
        } else {
            radioButton.setImage(AppImages.radioButtonDisenabled, for: .normal)
        }
    }
    
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            radioButton.widthAnchor.constraint(equalToConstant: AppLayout.DetailsCar.Cell.diametrRadioButton),
            radioButton.heightAnchor.constraint(equalToConstant: AppLayout.DetailsCar.Cell.diametrRadioButton),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.DetailsCar.Cell.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.DetailsCar.Cell.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                    constant: AppLayout.DetailsCar.Cell.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                  constant: AppLayout.DetailsCar.Cell.bottomTopMainStackView),
        ])
    }
    
    // MARK: Actions
    @objc func radioButtonTouchUpInside() {
        guard let type = typeOfBody else { return }
        //enabledRadioButton = true
        radioButtonTouchUpInsideHandler?(type)
    }
}

// MARK:  - IListCarsCell
extension DetailsCarCell: IDetailsCarCell {
    func configure (with viewModel: TableDetailsCarViewModel) {
        typeOfBodyLabel.text = viewModel.stringTypeOfBody
        configureEnabledRadioButton(enabledRadioButton: viewModel.enabledRadioButton)
    }
    
    func setTypeOfBody (typeOfBody: TypeOfBody) {
        self.typeOfBody = typeOfBody
    }
}
