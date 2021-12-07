//
//  DetailsCarModel.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import UIKit

protocol IDetailsCarModel {
    func fetchCar(id: UUID, closure: @escaping ((Car) -> Void))
    func fetchTypeOfBody(id: UUID, selectTypeOfBody: SelectTypeOfBody, closure: @escaping ((TypeOfBody) -> Void))
}

final class DetailsCarModel {
    
}

// MARK: - IListCarsModel
extension DetailsCarModel: IDetailsCarModel{
    func fetchCar(id: UUID, closure: @escaping ((Car) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now() + 1) {
            guard let car = CarsMock.shared.cars.filter({ (car) -> Bool in
                car.id == id
            }).first else {
                return closure( Car(makeOfCar: .errorMakeOfCar, typeOfBodies: [TypeOfBody.sedan(0, AppImages.errorCar, false)]))
            }
            closure(car)
        }
    }
    
    func fetchTypeOfBody(id: UUID, selectTypeOfBody: SelectTypeOfBody, closure: @escaping ((TypeOfBody) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now() + 1) {
            self.fetchCar(id: id) { (car) in
                guard let type = car.typeOfBodies.filter({ (typeOfBody) -> Bool in
                    typeOfBody.equal(selectTypeOfBody: selectTypeOfBody)
                }).first else {
                    return closure(TypeOfBody.sedan(0, AppImages.errorCar, false))
                }
                closure(type)
            }
        }
    }
}
