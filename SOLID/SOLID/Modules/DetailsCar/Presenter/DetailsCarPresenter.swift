//
//  DetailsCarPresenter.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import UIKit

protocol IDetailsCarPresenter {
    func loadView(view: IDetailsCarView, controller: IDetailsCarController)
}

final class DetailsCarPresenter {
    
    // MARK: - Properties
    private let idOfCar: UUID
    private var selectTypeOfBody: SelectTypeOfBody = .sedan
    
    private let model: IDetailsCarModel
    private var router: IDetailsCarRouter
    private let dataHandler: IDetailsCarDataHandler
    private weak var view: IDetailsCarView?
    private weak var controller: IDetailsCarController?
    
    // MARK: - Init
    init(model: IDetailsCarModel, router: IDetailsCarRouter, dataHandler: IDetailsCarDataHandler, idOfCar: UUID) {
        self.model = model
        self.router = router
        self.dataHandler = dataHandler
        self.idOfCar = idOfCar
    }
    
    // MARK: - Private functions
    private func getTypeOfBody(id: UUID, selectTypeOfBody: SelectTypeOfBody, closure: @escaping ((TypeOfBody) -> Void)) {
        model.fetchTypeOfBody(id: id, selectTypeOfBody: selectTypeOfBody) { (typeOfBody) in
            closure(typeOfBody)
        }
    }
    
    private func getCar(id: UUID, closure: @escaping ((Car) -> Void)) {
        model.fetchCar(id: id) { (car) in
            closure(car)
        }
    }
    
    private func getImageFromCar(_ car: Car, selectTypeOfBody: SelectTypeOfBody) -> UIImage {
        guard let typeOfBody = car.typeOfBodies.filter({ (typeOfBody) -> Bool in
            typeOfBody.equal(selectTypeOfBody: selectTypeOfBody)
        }).first else {
            return AppImages.errorCar
        }
        return typeOfBody.rawValue.image
    }
    
    private func getImageFromTypeOfBody(_ typeOfBody: TypeOfBody) -> UIImage {
        return typeOfBody.rawValue.image
    }
    
    // MARK: - Actions
    private func setHandlers() {
        dataHandler.radioButtonTouchUpInsideHandler = { [weak self] typeOfBody in
            self?.view?.reloadData()
            self?.selectTypeOfBody = typeOfBody.getSelectTypeOfBody()
            self?.view?.configureImage(with: DetailsCarViewModelFactory.getViewModel(from: typeOfBody))
        }
        
        view?.calculateCostButtonTouchUpInsideHandler = {[weak self] in
            self?.view?.startActivityIndicator()
            guard let idOfCar = self?.idOfCar,
                  let selectTypeOfBody = self?.selectTypeOfBody
            else { return }
            self?.model.fetchTypeOfBody(id: idOfCar, selectTypeOfBody: selectTypeOfBody, closure: { (typeOfBody) in
                DispatchQueue.main.async {
                    self?.view?.configureCost(with: DetailsCarViewModelFactory.getViewModel(from: typeOfBody))
                    self?.view?.stopActivityIndicator()
                }
            })
        }
        
        controller?.backListCarsHandler = { [weak self] in
            self?.router.backToListCars()
        }
        
        router.backToListCarsHandler = { [weak self] in
            self?.controller?.popToListCars()
        }
    }
}

extension DetailsCarPresenter: IDetailsCarPresenter {
    
    func loadView(view: IDetailsCarView, controller: IDetailsCarController) {
        self.view = view
        self.controller = controller
        view.setTableViewDataSource(object: dataHandler)
        view.setTableViewDelegate(object: dataHandler)
        view.registerTableViewCell(DetailsCarCell.self)
        view.registerTableViewHeaderCell(DetailsCarHeaderView.self)
        controller.hideNavigationBar()
        view.showDownloadView()
        getCar (id: idOfCar) { [weak self]  (car) in
            guard let selectTypeOfBody = self?.selectTypeOfBody
            else { return }
            self?.dataHandler.setTypesOfBody(typesOfBody: car.typeOfBodies)
            DispatchQueue.main.async {
                controller.configure()
                self?.view?.reloadData()
                guard let typeOfBody = car.typeOfBodies.filter({ (typeOfBody) -> Bool in
                    typeOfBody.equal(selectTypeOfBody: selectTypeOfBody)
                }).first
                else { return }
                view.configureCost(with: DetailsCarViewModelFactory.getViewModel(from: typeOfBody))
                view.configureImage(with: DetailsCarViewModelFactory.getViewModel(from: typeOfBody))
                self?.view?.hideDownloadView()
                self?.controller?.showNavigationBar()
            }
        }
        setHandlers()
    }
}

