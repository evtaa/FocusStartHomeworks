//
//  WorkExperiencePersonalInfoCell.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 13.11.2021.
//

import UIKit

final class WorkExperienceProfileCell: UITableViewCell {
    
    // MARK: - Subviews
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = AppLayout.Profile.cornerRadius
        view.backgroundColor = AppColors.contentBackground
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [timePeriodLabel, companyLabel, positionLabel, responsibilitiesLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = AppLayout.Profile.WorkExperienceCell.spacingStackView
        view.backgroundColor = AppColors.contentBackground
        return view
    }()
    
    private let timePeriodLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.smallSystem
        label.textColor = AppColors.unimportantLabel
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.system
        return label
    }()
    
    private let responsibilitiesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.smallSystem
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayoutContentView()
        configureLayoutMainView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func configure(with model: WorkExperienceItemViewModel) {
        timePeriodLabel.text = model.timePeriod
        companyLabel.text = model.company
        positionLabel.text = model.position
        responsibilitiesLabel.text = model.responsibilities
    }
    
    // MARK: - Private functions
    private func configureUI() {
        contentView.backgroundColor = AppColors.background
    }
    
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                          constant: AppLayout.Profile.WorkExperienceCell.topMainView),
            mainView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            mainView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                             constant: AppLayout.Profile.WorkExperienceCell.bottomMainView),
        ])
    }
    
    private func configureLayoutMainView() {
        let safeArea = mainView.safeAreaLayoutGuide
        mainView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.Profile.WorkExperienceCell.topStackView),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.Profile.WorkExperienceCell.leadingStackView),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.Profile.WorkExperienceCell.trailingStackView),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: AppLayout.Profile.WorkExperienceCell.bottomStackView)
        ])
    }
}
