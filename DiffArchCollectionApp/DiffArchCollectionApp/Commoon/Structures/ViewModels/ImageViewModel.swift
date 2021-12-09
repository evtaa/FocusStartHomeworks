//
//  ImageViewModel.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

protocol IImageViewModel {
    var image: UIImage { get }
    var name: String { get }
    var info: String { get }
}

struct ImageViewModel {
    let image: UIImage
    let name: String
    let info: String
}

// MARK: - IImageViewModel
extension ImageViewModel: IImageViewModel {
}
