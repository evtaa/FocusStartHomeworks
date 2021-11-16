//
//  PersonalInformationView.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

final class PersonalInfoView: UIView {
    
    // MARK: - SubView
    private(set) var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [AppText.PersonalInfo.segmentCommon,
                                                          AppText.PersonalInfo.segmentEducation])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
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
    
    private(set) var commonPersonalInfoView: CommonPersonalInfoView = {
        let view = CommonPersonalInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var educationTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = AppLayout.PersonalInfo.tableEstimatedRowHeight
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
        commonPersonalInfoView.configure(with: person)
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = AppColors.background
    }
    
    private func configureLayout() {
        configureLayoutView()
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(segmentedControl)
        addSubview(commonPersonalInfoView)
        addSubview(educationTableView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                  constant: AppLayout.PersonalInfo.topSegmentedControl),
            segmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                      constant: AppLayout.PersonalInfo.leadingSegmentedControl),
            segmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                       constant: AppLayout.PersonalInfo.trailingSegmentedControl),
            segmentedControl.heightAnchor.constraint(equalToConstant: AppLayout.PersonalInfo.heightSegmentedControl),
            
        ])
        
        NSLayoutConstraint.activate([
            commonPersonalInfoView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor,
                                                        constant: AppLayout.PersonalInfo.topForCommonAndEducationView),
            commonPersonalInfoView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor),
            commonPersonalInfoView.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor),
            commonPersonalInfoView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                           constant: AppLayout.PersonalInfo.bottomForCommonAndEducationView),
        ])
        
        NSLayoutConstraint.activate([
            
            educationTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor,
                                                        constant: AppLayout.PersonalInfo.topForCommonAndEducationView),
            educationTableView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor),
            educationTableView.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor),
            educationTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                           constant: AppLayout.PersonalInfo.bottomForCommonAndEducationView),
        ])
    }
}
