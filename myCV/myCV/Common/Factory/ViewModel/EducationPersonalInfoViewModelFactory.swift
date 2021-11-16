//
//  EducationPersonalInfoViewModelFactory.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 12.11.2021.
//

import Foundation

final class EducationViewModelFactory {
    static func viewModel (from model: EducationItem) -> EducationItemViewModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let dateOfEnd = dateFormatter.string(from: model.dateOfEnd)
        let headerInfo = model.headerInfo
        let info = model.info
        return EducationItemViewModel(dateOfEnd: dateOfEnd, headerInfo: headerInfo, info: info)
        }
}
