//
//  CommonProfileViewModelFactory.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 13.11.2021.
//

import Foundation

final class CommonProfileViewModelFactory {
    static func viewModel (from model: Person) -> CommonProfileViewModel {
        let demoProfile = model.profile.demoProfile
        let info = model.profile.info
        let additionalInfo = model.profile.additionalInfo
        return CommonProfileViewModel(demoProfile: demoProfile, info: info, additionalInfo: additionalInfo)
        }
}
