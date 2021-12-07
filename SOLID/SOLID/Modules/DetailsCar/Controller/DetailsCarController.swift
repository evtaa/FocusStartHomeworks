//
//  DetailsCarController.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import UIKit

protocol IDetailsCarController: UIViewController {
    var backListCarsHandler: (() -> Void)? { get set }
    
    func configure()
    func popToListCars()
    func showNavigationBar()
    func hideNavigationBar()
}

class DetailsCarController: UIViewController {

    // MARK: Properties
    private let presenter: IDetailsCarPresenter
    private var rootView: IDetailsCarView {
        view as? IDetailsCarView ?? DetailsCarView()
    }
    
    // MARK: - Handlers
    var backListCarsHandler: (() -> Void)?
    
    // MARK: Init
    init(presenter: IDetailsCarPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycles
    override func loadView() {
        let detailsCarView: IDetailsCarView = DetailsCarView()
        view = detailsCarView
        presenter.loadView(view: rootView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Configure
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        let backButton = UIBarButtonItem(title: AppText.DetailsCar.leftButtonItem,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backListCars))
        backButton.tintColor = AppColors.DetailsCar.textButtonItem
        navigationController?.navigationBar.topItem?.leftBarButtonItem = backButton
    }
    
    // MARK: - Actions
    @objc private func backListCars() {
        backListCarsHandler?()
    }
}

// MARK: IDetailsCarController
extension DetailsCarController: IDetailsCarController {
    func configure() {
        configureNavigationBar()
    }
    
    func popToListCars() {
        navigationController?.popViewController(animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}
