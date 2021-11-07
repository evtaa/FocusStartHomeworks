//
//  ListViewController.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import UIKit

class ListCarsViewController: BaseViewController<ListCarsView> {
    
    // MARK: - Public properties
    let searchController = UISearchController(nibName: nil, bundle: nil)
    private var allCars: [Car]? = []
    var shownCars: [Car]? {
        didSet {
            rootView.tableView.reloadData()
        }
    }
    var selectedBodyOfCar: BodyOfCarForPickerView = .every
    
    // MARK: - GestureRecognizer
    private let tapRootView = UITapGestureRecognizer()

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFilterShownCarsBySelectedBody()
    }
    
    // MARK: - ConfigureUI
    private func configure () {
        setInitialCars()
        configureNavigationBar()
        configureGestureRecognizer()
        configureSearchController()
        configureTableView()
        configureTypeOfBodyPickerView()
        configureAddButton()
    }
    
    private func configureNavigationBar () {
        title = Text.bodySearch
    }
    
    private func configureGestureRecognizer() {
        tapRootView.cancelsTouchesInView = false
        tapRootView.addTarget(self, action: #selector(dismissKeyboardTapGestureRecognizer))
        rootView.addGestureRecognizer(tapRootView)
    }
    
    private func configureSearchController () {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.setShowsScope(false, animated: false)
        searchController.searchBar.placeholder = Text.bodySearch
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchBar.searchTextField.inputView = rootView.typeOfBodyPickerView
        searchController.searchBar.searchTextField.text = BodyOfCarForPickerView.every.rawValue
        
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
    }
    
    private func configureTableView () {
        rootView.tableView.register(ListCarsTableViewCell.self)
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func configureTypeOfBodyPickerView() {
        rootView.typeOfBodyPickerView.dataSource = self
        rootView.typeOfBodyPickerView.delegate = self
    }
    
    private func configureAddButton () {
        rootView.addButton.addTarget(self, action: #selector(addButtonTouchUpInside),
                                     for: .touchUpInside)
    }
    
    // MARK: - Private functions
    private func setInitialCars() {
        allCars = CarsMock.shared.cars
        shownCars = allCars
    }
    
    func setFilterShownCarsBySelectedBody() {
        if selectedBodyOfCar != .every {
            shownCars = allCars?.filter({ (car) -> Bool in
                car.body.equal(bodyOfCarForPickerView: selectedBodyOfCar)
            })
        } else {
            shownCars = allCars
        }
    }
    
    // MARK: - Actions
    @objc private func addButtonTouchUpInside() {
        goToDetailsCarViewController()
    }
    
    //MARK: - Navigation
    private func goToDetailsCarViewController() {
        let vc = DetailsCarAssembly.vc()
        vc.detailsCarDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dismissKeyboardTapGestureRecognizer() {
        searchController.searchBar.endEditing(true)
        rootView.typeOfBodyPickerView.isHidden = true
    }
}

// MARK: - DetailsCarViewControllerDelegate
extension ListCarsViewController: DetailsCarViewControllerDelegate {
    func getNewCar(car: Car) {
        allCars?.append(car)
    }
}

//MARK: - UITextFieldDelegate
extension ListCarsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        rootView.typeOfBodyPickerView.isHidden = false
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return false
    }
}

//MARK: - UISearchResultsUpdating
extension ListCarsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.searchTextField.text = selectedBodyOfCar.rawValue
    }
}

//MARK: - UISearchBarDelegate
extension ListCarsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.searchTextField.text = selectedBodyOfCar.rawValue
        selectedBodyOfCar = BodyOfCarForPickerView.every
        searchController.searchBar.searchTextField.text =  selectedBodyOfCar.rawValue
        setFilterShownCarsBySelectedBody()
    }
}

//MARK: - UISearchControllerDelegate
extension ListCarsViewController: UISearchControllerDelegate {
    
}


