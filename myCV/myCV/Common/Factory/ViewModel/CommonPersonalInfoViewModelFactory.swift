//
//  PersonalInfoViewModelFactory.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 12.11.2021.
//

import Foundation
import UIKit

final class CommonPersonalInfoViewModelFactory {
    static func viewModel (from model: Person) -> CommonPersonalInfoViewModel {
        let avatar = model.personalInfo.avatar
        let name = model.personalInfo.name
        let age = String(model.personalInfo.age)
        let address = model.personalInfo.address
        let mobile = model.personalInfo.mobile
        let nationality = model.personalInfo.nationality
        let email = model.personalInfo.email
        return CommonPersonalInfoViewModel(avatar: avatar,
                                           name: name,
                                           age: age,
                                           address: address,
                                           mobile: mobile,
                                           nationality: nationality,
                                           email: email)
        }
}
