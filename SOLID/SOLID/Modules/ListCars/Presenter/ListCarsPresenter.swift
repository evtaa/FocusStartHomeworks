//
//  ListCarsPresenter.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import Foundation

protocol IListCarsPresenter {
    func loadView(view: IListCarsView, controller: IListCarsController)
    func getListCars(closure: @escaping (([Car]) -> Void))
}

final class ListCarsPresenter {
    
    // MARK: - Properties
    private let model: IListCarsModel
    private var router: IListCarsRouter
    private let dataHandler: IListCarsDataHandler
    private weak var view: IListCarsView?
    private weak var controller: IListCarsController?
    
    // MARK: - Init
    init(model: IListCarsModel, router: IListCarsRouter, dataHandler: IListCarsDataHandler) {
        self.model = model
        self.router = router
        self.dataHandler = dataHandler
    }
    
    // MARK: - Actions
    private func setHandlers() {
        dataHandler.selectButtonTouchUpInsideHandler = { [weak self] idOfCar in
            self?.router.goToDetailsCar(idOfCar: idOfCar)
        }
        
        router.goToDetailsCarHandler = {[weak self] idOfCar in
            self?.controller?.pushDetailsCar(idOfCar: idOfCar)
        }
    }
}

extension ListCarsPresenter: IListCarsPresenter {
    func loadView(view: IListCarsView, controller: IListCarsController) {
        self.view = view
        self.controller = controller
        view.setTableViewDataSource(object: dataHandler)
        view.setTableViewDelegate(object: dataHandler)
        view.registerTableViewCell(ListCarsCell.self)
        view.registerTableViewHeaderCell(ListCarsHeaderView.self)
        getListCars { [weak self]  (cars) in
            self?.dataHandler.setCars(cars: cars)
            DispatchQueue.main.async {
                self?.view?.reloadData()
            }
        }
        controller.configure()
        setHandlers()
    }
    
    func getListCars(closure: @escaping (([Car]) -> Void)) {
        model.fetchListCars { (cars) in
            closure(cars)
        }
    }
}
