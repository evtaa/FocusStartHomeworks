//
//  ListCarsController.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import UIKit

protocol IListCarsController: UIViewController {
    func configure()
    func pushDetailsCar(idOfCar: UUID)
}

final class ListCarsController: UIViewController {
    
    // MARK: Properties
    private let presenter: IListCarsPresenter
    private var rootView: IListCarsView {
        view as? IListCarsView ?? ListCarsView()
    }
    
    // MARK: Init
    init(presenter: IListCarsPresenter) {
        self.presenter = presenter
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycles
    override func loadView() {
        let listCarsView: IListCarsView = ListCarsView()
        view = listCarsView
        presenter.loadView(view: rootView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Configure
    private func configureNavigationBar() {
        title = AppText.ListCars.title
        let appearance = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.font: AppFonts.titleNavigationBar]
        appearance.titleTextAttributes = attributes
        appearance.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
    }
}

// MARK: IListCarsController
extension ListCarsController: IListCarsController {
    func configure() {
        configureNavigationBar()
    }
    
    func pushDetailsCar(idOfCar: UUID) {
        let vc = DetailsCarAssembler.assemble(idOfCar: idOfCar)
        navigationController?.pushViewController(vc, animated: true)
    }
}

