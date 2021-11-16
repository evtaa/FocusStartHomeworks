//
//  ProfileView.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

final class ProfileView: UIView {

    // MARK: - SubView
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [segmentedControl,commonProfileView, workExperienceTableView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = AppLayout.Profile.spacingMainStackView
        view.setCustomSpacing(AppLayout.Profile.customSpacingCommonForProfileView,
                              after: commonProfileView)
        view.backgroundColor = AppColors.background
        return view
    }()
    
    private(set) var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [AppText.Profile.segmentProfile,
                                                          AppText.Profile.segmentWorkExperience])
        segmentedControl.selectedSegmentTintColor = AppColors.segmentActive
        segmentedControl.backgroundColor = AppColors.segmentNoActive
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: AppColors.segmentTextActive,
             NSAttributedString.Key.font: AppFonts.systemBold ],
            for: .selected)
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: AppColors.segmentTextNoActive,
             NSAttributedString.Key.font: AppFonts.systemBold],
            for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private(set) var commonProfileView: CommonProfileView = {
        let view = CommonProfileView()
        return view
    }()
    
    private(set) var workExperienceTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = AppLayout.Profile.tableEstimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets.zero
        tableView.backgroundColor = AppColors.background
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = AppLayout.PersonalInfo.cornerRadius
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func configure(with person: Person) {
        commonProfileView.configure(with: person)
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = AppColors.background
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: AppLayout.Profile.heightSegmentedControl),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.Profile.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.Profile.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                    constant: AppLayout.Profile.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                  constant: AppLayout.Profile.bottomMainStackView),
        ])
    }
}
