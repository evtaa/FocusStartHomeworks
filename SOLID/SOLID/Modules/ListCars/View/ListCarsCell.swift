//
//  ListCarsCell.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import UIKit

protocol IListCarsCell: UITableViewCell {
    var selectButtonTouchUpInsideHandler: ((_ id: UUID) -> Void)? { get set }
    
    func configure (with viewModel: ListCarsViewModel)
    func setIdOfCar (id: UUID)
    func setColorForMarkView(_ color: UIColor)
}

final class ListCarsCell: UITableViewCell {
    
    // MARK: - Properties
    var idOfCar: UUID?
    
    //MARK: - Handlers
    var selectButtonTouchUpInsideHandler: ((_ id: UUID) -> Void)?
    
    // MARK: - Subviews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [markView,
                                                       titleLabel,
                                                       selectButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = AppLayout.ListCars.Cell.spacingMainStackView
        return stackView
    }()
    
    private let markView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = AppLayout.ListCars.Cell.radiusCircleView
        //view.backgroundColor = AppColors.ListCars.Cell.markViewColor
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.system
        label.textAlignment = .left
        return label
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setTitleColor(AppColors.ListCars.Cell.buttonTitleColor, for: .normal)
        button.setTitle(AppText.ListCars.Cell.buttonText, for: .normal)
        button.backgroundColor = AppColors.ListCars.Cell.buttonColor
        button.titleLabel?.font = AppFonts.smallSystem
        button.addTarget(self, action: #selector(selectButtonTouchUpInside), for: .touchUpInside)
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
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            markView.widthAnchor.constraint(equalToConstant: AppLayout.ListCars.Cell.diametrCircleView),
            markView.heightAnchor.constraint(equalToConstant: AppLayout.ListCars.Cell.diametrCircleView),
            selectButton.widthAnchor.constraint(equalToConstant: AppLayout.ListCars.Cell.widthButton),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.ListCars.Cell.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.ListCars.Cell.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                    constant: AppLayout.ListCars.Cell.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                    constant: AppLayout.ListCars.Cell.bottomTopMainStackView),
        ])
    }
    
    // MARK: Actions
    @objc private func selectButtonTouchUpInside() {
        guard let id = idOfCar else { return }
        selectButtonTouchUpInsideHandler?(id)
    }
}

// MARK:  - IListCarsCell
extension ListCarsCell: IListCarsCell {
    func configure (with viewModel: ListCarsViewModel) {
        titleLabel.text = viewModel.makeOfCar
    }
    
    func setIdOfCar (id: UUID) {
        idOfCar = id
    }
    
    func setColorForMarkView(_ color: UIColor) {
        markView.backgroundColor = color
    }
}
