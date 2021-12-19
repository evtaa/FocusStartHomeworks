//
//  EditEmployeeController.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import UIKit

protocol IEditEmployeeController: UIViewController  {
    var touchDoneTouchUpInsideHandler: (() -> Void)? { get set }
    
    func configure()
    func backToListEmployee()
    func showFailedNameOfEmployee()
    func showFailedAgeOfEmployee()
    func showFailedExperienceOfEmployee()
    func showAlert(error: Error)
}

final class EditEmployeeController: UIViewController, ShowAlert {

    // MARK: Properties
    private let presenter: IEditEmployeePresenter
    private var rootView: IEditEmployeeView {
        view as? IEditEmployeeView ?? EditEmployeeView()
    }
    
    // MARK: - Handlers
    var touchDoneTouchUpInsideHandler: (() -> Void)?
    
    // MARK: Structures
    struct Dependencies {
        let presenter: IEditEmployeePresenter
    }
    
    // MARK: Init
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycles
    override func loadView() {
        let newView: IEditEmployeeView = EditEmployeeView()
        view = newView
        presenter.loadView(view: rootView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureNavigationBar()
    }
    
    // MARK: Configure
    private func configureNavigationBar() {
        title = AppText.titleEditEmployee
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        
        let backButton = UIBarButtonItem(title: AppText.done,
                                         style: .plain,
                                         target: self,
                                         action: #selector(touchDoneTouchUpInside))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = backButton
    }
    
    // MARK: - Actions
    @objc private func touchDoneTouchUpInside() {
        touchDoneTouchUpInsideHandler?()
    }
}

// MARK: IEditEmployeeController
extension EditEmployeeController: IEditEmployeeController {
    func configure() {
    }
    
    func backToListEmployee() {
        navigationController?.popViewController(animated: true)
    }
    
    func showFailedNameOfEmployee() {
        showError(forViewController: self, withMessage: AppText.alertNameOfEmployee)
    }
    
    func showFailedAgeOfEmployee() {
        showError(forViewController: self, withMessage: AppText.alertAgeOfEmployee)
    }
    
    func showFailedExperienceOfEmployee() {
        showError(forViewController: self, withMessage: AppText.alertExperienceOfEmployee)
    }
    
    func showAlert(error: Error) {
        showError(forViewController: self, withMessage: AppText.alertOfCoreData + ": " + error.localizedDescription)
    }
}

