//
//  PhotoInterestsViewModelFactory.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 14.11.2021.
//

import Foundation

final class PhotoInterestsViewModelFactory {
    static func viewModel (from model: PhotoInterestsItem) -> PhotoInterestsItemViewModel {
        let photo = model.photo
        return PhotoInterestsItemViewModel(photo: photo)
        }
}
