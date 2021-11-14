//
//  ProfileController.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

final class ProfileController: BaseViewController<ProfileView> {
    
    // MARK: - Properties
    private var typeOfProfile: TypeOfProfile = .profile
    private var person: Person?
    private var workExperienceItems: [WorkExperienceItem]? {
        get {
            person?.profile.workExperience
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setTypeOfProfile()
        showViewsByTypeOfProfile()
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
        rootView.segmentedControl.addTarget(self, action: #selector(changeTypeOfProfile), for: .valueChanged)
    }
    
    private func configureTableView() {
        rootView.workExperienceTableView.register(WorkExperienceProfileCell.self)
        rootView.workExperienceTableView.dataSource = self
        rootView.workExperienceTableView.delegate = self
    }
    
    // MARK: - Private functions
    private func configureMockData () {
        person = PersonMock.shared.person
    }
    
    private func setTypeOfProfile() {
        switch rootView.segmentedControl.selectedSegmentIndex {
        case 0:
            typeOfProfile = .profile
        case 1:
            typeOfProfile = .workExperience
        default:
            break
        }
    }
    
    private func showViewsByTypeOfProfile() {
        switch typeOfProfile {
        case .profile:
            showProfileInfo()
        case .workExperience:
            showWorkExperienceInfo()
            rootView.workExperienceTableView.reloadData()
        }
    }
    
    private func showProfileInfo() {
        rootView.commonProfileView.isHidden = false
        rootView.workExperienceTableView.isHidden = true
    }
    
    private func showWorkExperienceInfo() {
        rootView.commonProfileView.isHidden = true
        rootView.workExperienceTableView.isHidden = false
    }
    
    // MARK: - Actions
    @objc private func changeTypeOfProfile() {
        setTypeOfProfile()
        showViewsByTypeOfProfile()
    }
}

extension ProfileController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = workExperienceItems?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: WorkExperienceProfileCell.self, for: indexPath)
        guard let workExperience = workExperienceItems?[indexPath.row] else { return cell}
        let workExperienceViewModel = WorkExperienceViewModelFactory.viewModel(from: workExperience)
        cell.configure(with: workExperienceViewModel)
        return cell
    }
}

extension ProfileController: UITableViewDelegate {
    
}

    
