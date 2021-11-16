//
//  PersonalInformationController.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

final class PersonalInfoController: BaseViewController<PersonalInfoView> {
    
    // MARK: - Properties
    private var typeOfPersonalInfo: TypeOfPersonalInfo = .common
    private var person: Person?
    private var educationItems: [EducationItem]? {
        get {
            person?.personalInfo.educationItems
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setTypeOfPersonalInfo()
        showViewsByTypeOfPersonalInfo()
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        configureMockData()
        configureSegmentControl()
        configureNavigationBar()
        configureTableView()
        guard let person = person else {return}
        rootView.configure(with: person)
    }
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    private func configureSegmentControl() {
        rootView.segmentedControl.addTarget(self, action: #selector(changeTypeOfPersonalInfo), for: .valueChanged)
    }
    
    private func configureTableView() {
        rootView.educationTableView.register(EducationPersonalInfoCell.self)
        rootView.educationTableView.dataSource = self
    }
    
    // MARK: - Private functions
    private func configureMockData () {
        person = PersonMock.shared.person
    }
    
    private func setTypeOfPersonalInfo() {
        switch rootView.segmentedControl.selectedSegmentIndex {
        case 0:
            typeOfPersonalInfo = .common
        case 1:
            typeOfPersonalInfo = .education
        default:
            break
        }
    }
    
    private func showViewsByTypeOfPersonalInfo() {
        switch typeOfPersonalInfo {
        case .common:
            showCommonInfo()
        case .education:
            showEducationInfo()
            rootView.educationTableView.reloadData()
        }
    }
    
    private func showCommonInfo() {
        rootView.commonPersonalInfoView.isHidden = false
        rootView.educationTableView.isHidden = true
    }
    
    private func showEducationInfo() {
        rootView.commonPersonalInfoView.isHidden = true
        rootView.educationTableView.isHidden = false
    }
    
    // MARK: - Actions
    @objc private func changeTypeOfPersonalInfo() {
        setTypeOfPersonalInfo()
        showViewsByTypeOfPersonalInfo()
    }
}

extension PersonalInfoController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = educationItems?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: EducationPersonalInfoCell.self, for: indexPath)
        guard let education = educationItems?[indexPath.row] else { return cell}
        let educationViewModel = EducationViewModelFactory.viewModel(from: education)
        cell.configure(with: educationViewModel)
        return cell
    }
}

