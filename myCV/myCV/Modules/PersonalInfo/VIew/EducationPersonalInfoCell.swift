//
//  EducationPersonalInfoCell.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 12.11.2021.
//

import UIKit

final class EducationPersonalInfoCell: UITableViewCell {

    // MARK: - Subviews
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let endEducationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.smallSystem
        label.textColor = AppColors.unimportantLabel
        return label
    }()
    
    private let headerInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    func configure(with model: EducationItemViewModel) {
        endEducationLabel.text = model.dateOfEnd
        headerInfoLabel.text = model.headerInfo
        infoLabel.text = model.info
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = AppColors.background
        contentView.backgroundColor = AppColors.background
        configureMainView()
    }
    private func configureMainView() {
        mainView.backgroundColor = AppColors.contentBackground
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = AppLayout.PersonalInfo.cornerRadius
    }
    // MARK: - ConfigureLayout
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: AppLayout.PersonalInfo.EducationCell.topMainView),
            mainView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: AppLayout.PersonalInfo.EducationCell.bottomMainView),
        ])
    }
    
    private func configureLayoutMainView () {
        let safeArea = mainView.safeAreaLayoutGuide
        mainView.addSubview(endEducationLabel)
        mainView.addSubview(headerInfoLabel)
        mainView.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            endEducationLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                   constant: AppLayout.PersonalInfo.EducationCell.topTimePeriod),
            endEducationLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: AppLayout.PersonalInfo.EducationCell.leadingTimePeriod),
            endEducationLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: AppLayout.PersonalInfo.EducationCell.trailingTimePeriod),
            
            headerInfoLabel.topAnchor.constraint(equalTo: endEducationLabel.bottomAnchor, constant: AppLayout.PersonalInfo.EducationCell.topLabel),
            headerInfoLabel.leadingAnchor.constraint(equalTo: endEducationLabel.leadingAnchor),
            headerInfoLabel.trailingAnchor.constraint(equalTo: endEducationLabel.trailingAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: headerInfoLabel.bottomAnchor,
                                           constant: AppLayout.PersonalInfo.EducationCell.topLabel),
            infoLabel.leadingAnchor.constraint(equalTo: headerInfoLabel.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: headerInfoLabel.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: AppLayout.PersonalInfo.EducationCell.bottomLabel),
        ])
    }


}
