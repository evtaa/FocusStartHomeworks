//
//  CommonInterestsViewModelFactory.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 14.11.2021.
//

import Foundation

final class CommonInterestsViewModelFactory {
    static func viewModel (from model: Person) -> CommonInterestsViewModel {
        let interests = model.interests.interests
        return CommonInterestsViewModel(interests: interests)
        }
}
