//
//  TableDetailsCarViewModelFactory.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import Foundation

final class TableDetailsCarViewModelFactory {
    static func getViewModel(from typeOfBody: TypeOfBody) -> TableDetailsCarViewModel {
        let stringTypeOfBody = typeOfBody.rawValue.name
        let enabledRadioButton = typeOfBody.rawValue.isEnabled
        return TableDetailsCarViewModel(stringTypeOfBody: stringTypeOfBody, enabledRadioButton: enabledRadioButton)
    }
}
