//
//  DetailsCarViewModelFactory.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 05.12.2021.
//

import UIKit

final class DetailsCarViewModelFactory {
    static func getViewModel(from typeOfBody: TypeOfBody) -> DetailsCarViewModel {
        let image = typeOfBody.rawValue.image
        let cost = String(typeOfBody.rawValue.cost) + "$"
        return DetailsCarViewModel(image: image, cost: cost)
    }
}
