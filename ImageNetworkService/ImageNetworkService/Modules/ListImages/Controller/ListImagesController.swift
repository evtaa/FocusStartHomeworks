//
//  ListImagesController.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListImagesController: UIViewController, ShowAlert {
    func configureSearchController(object: UISearchControllerDelegate & UISearchResultsUpdating & UISearchBarDelegate)
    func showErrorURL()
    func showErrorInternet(stringError: String)
}

class ListImagesController: UIViewController {
    
    //MARK: - Private properties
    private let searchController: UISearchController = {
        let controller = UISearchController(nibName: nil,
                                            bundle: nil)
        controller.searchBar.placeholder = AppText.ListImages.searchPlaceholder
        controller.searchBar.sizeToFit()
        return controller
    }()
    
    // MARK: Properties
    private let presenter: IListImagesPresenter
    private var rootView: IListImagesView {
        view as? IListImagesView ?? ListImagesView()
    }
    
    // MARK: Init
    init(presenter: IListImagesPresenter) {
        self.presenter = presenter
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycles
    override func loadView() {
        let listImagesView: IListImagesView = ListImagesView()
        view = listImagesView
        presenter.loadView(view: rootView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    private func configure () {
        configureSearchController()
       
    }
    
    private func configureSearchController () {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.text = AppText.ListImages.Cell.defaultURL
    }
}

// MARK: IController
extension ListImagesController: IListImagesController {
    func configureSearchController(object: UISearchControllerDelegate & UISearchResultsUpdating & UISearchBarDelegate) {
        searchController.delegate = object
        searchController.searchResultsUpdater = object
        searchController.searchBar.delegate = object
    }
    
    func showErrorURL() {
        showError(forViewController: self, withMessage: "Неправильно введен адрес")
    }
    
    func showErrorInternet(stringError: String) {
        showError(forViewController: self, withMessage: "Ошибка сети: " + stringError)
    }
}
