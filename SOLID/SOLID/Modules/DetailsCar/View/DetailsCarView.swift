//
//  DetailsCarView.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 05.12.2021.
//

import UIKit

protocol IDetailsCarView: UIView {
    var calculateCostButtonTouchUpInsideHandler: (() -> Void)? { get set }
    
    func configureCost(with model: DetailsCarViewModel)
    func configureImage(with model: DetailsCarViewModel)
    func setTableViewDataSource(object : UITableViewDataSource)
    func setTableViewDelegate(object : UITableViewDelegate)
    func registerTableViewCell (_ cellType: UITableViewCell.Type)
    func registerTableViewHeaderCell (_ cellType: UITableViewHeaderFooterView.Type)
    func reloadData()
    func startActivityIndicator()
    func stopActivityIndicator()
    func showDownloadView()
    func hideDownloadView()
}

final class DetailsCarView: UIView {
    
    //MARK: - Handlers
    var calculateCostButtonTouchUpInsideHandler: (() -> Void)?
    
    // MARK: - Subviews
    private let downloadView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.backgroundColor
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = AppColors.DetailsCar.activityIndicator
        indicator.style = .large
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView,
                                                       costLabel,
                                                       costValueLabel,
                                                       tableView,
                                                       calculateCostButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.DetailsCar.spacingMainStackView
        stackView.setCustomSpacing(AppLayout.DetailsCar.customSpacingAfterCostLabel,
                                   after: costLabel)
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.bigSystem
        label.text = AppText.DetailsCar.costLabel
        label.textAlignment = .left
        return label
    }()
    
    private let costValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.smallSystem
        label.textAlignment = .left
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = AppLayout.DetailsCar.tableEstimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = AppLayout.DetailsCar.tableEstimatedRowHeight
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var calculateCostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(AppText.DetailsCar.calculateCostButton, for: .normal)
        button.setTitleColor(AppColors.DetailsCar.textButtonColor, for: .normal)
        button.backgroundColor = AppColors.DetailsCar.buttonColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = AppLayout.DetailsCar.cornerRadiusButton
        button.addTarget(self, action: #selector(calculateCostButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayoutView()
        backgroundColor = AppColors.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(mainStackView)
        addSubview(activityIndicator)
        downloadView.addSubview(activityIndicator)
        addSubview(downloadView)
        NSLayoutConstraint.activate([
            downloadView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            downloadView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            downloadView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            downloadView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            calculateCostButton.heightAnchor.constraint(equalToConstant: AppLayout.DetailsCar.heightButton),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.DetailsCar.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.DetailsCar.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                    constant: AppLayout.DetailsCar.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                  constant: AppLayout.DetailsCar.bottomMainStackView),
            imageView.heightAnchor.constraint(equalToConstant: AppLayout.DetailsCar.heightImageView),
            
        ])
    }
    
    // MARK: Actions
    @objc func calculateCostButtonTouchUpInside() {
        calculateCostButtonTouchUpInsideHandler?()
    }
}

// MARK: IDetailsCarView
extension DetailsCarView: IDetailsCarView {
    func configureCost(with model: DetailsCarViewModel) {
        costValueLabel.text = model.cost
    }
    func configureImage(with model: DetailsCarViewModel) {
        imageView.image = model.image
    }
    
    func setTableViewDataSource(object : UITableViewDataSource) {
        tableView.dataSource = object
    }
    
    func setTableViewDelegate(object : UITableViewDelegate) {
        tableView.delegate = object
    }
    
    func registerTableViewCell (_ cellType: UITableViewCell.Type) {
        tableView.register(cellType)
    }
    
    func registerTableViewHeaderCell (_ cellType: UITableViewHeaderFooterView.Type) {
        tableView.register(cellType)
    }
    
    func reloadData () {
        tableView.reloadData()
    }
    
    func startActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func showDownloadView() {
        downloadView.isHidden = false
    }
    
    func hideDownloadView() {
        downloadView.isHidden = true
    }
}
