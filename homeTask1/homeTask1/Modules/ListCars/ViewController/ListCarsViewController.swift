//
//  ListViewController.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import UIKit

enum BodyOfCarForPickerView: String, CaseIterable {
    case every
    case sedan
    case hatchback
    case universal
    case coupe
}

class ListCarsViewController: BaseViewController<ListCarsView> {
    
    // MARK: - Public properties
    var allCars: [Car]? = []
    var shownCars: [Car]? = [] {
        didSet {
            rootView.tableView.reloadData()
        }
    }
    var selectedBodyOfCar: BodyOfCarForPickerView = .every
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
        setFilterShownCarsBySelectedBody()
    }
    
    // MARK: - ConfigureUI
    private func configure () {
        setInitialCars()
        configNavigationBar()
        configureTableView()
        configureTypeOfBodyPickerView()
        configureTypeOfBodyTextField()
        configureAddButton()
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.isHidden = true
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
    
    private func configureTypeOfBodyTextField() {
        rootView.typeOfBodyTextField.delegate = self
        rootView.typeOfBodyTextField.inputView = rootView.typeOfBodyPickerView
        rootView.typeOfBodyTextField.text = BodyOfCarForPickerView.every.rawValue
    }
    
    private func configureAddButton () {
        rootView.addButton.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - Private functions
    private func setInitialCars() {
        allCars = CarsMock.shared.cars
        shownCars = allCars
    }
    
    private func setFilterShownCarsBySelectedBody() {
        if selectedBodyOfCar != .every {
            shownCars = allCars?.filter({ (car) -> Bool in
                car.body.rawValue == selectedBodyOfCar.rawValue
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
        let vc = DetailsCarModuleFabric.vc()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - DetailsCarViewControllerDelegate
extension ListCarsViewController: DetailsCarViewControllerDelegate {
    func getNewCar(car: Car) {
        allCars?.append(car)
    }
}

// MARK: - UITableViewDataSource
extension ListCarsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let shownCars = shownCars else {
            return 0
        }
        return shownCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(ofType: ListCarsTableViewCell.self, for: indexPath)
        guard let car = shownCars?[indexPath.row] else {
            return dequeueCell
        }
        let viewModelCar = CarViewModelFactory.cellModel(from: car )
        dequeueCell.configure(with: viewModelCar)
        return dequeueCell
    }
}

// MARK: - UITableViewDelegate
extension ListCarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UIPickerViewDataSource
extension ListCarsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        BodyOfCarForPickerView.allCases.count
    }
}

//MARK: - UIPickerViewDelegate
extension ListCarsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        BodyOfCarForPickerView.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBodyOfCar = BodyOfCarForPickerView.allCases[row]
        rootView.typeOfBodyTextField.text = selectedBodyOfCar.rawValue
        setFilterShownCarsBySelectedBody()
        rootView.endEditing(true)
        rootView.typeOfBodyPickerView.isHidden = true
    }
}

//MARK: - UITextFieldDelegate
extension ListCarsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        rootView.typeOfBodyPickerView.isHidden = false
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}



