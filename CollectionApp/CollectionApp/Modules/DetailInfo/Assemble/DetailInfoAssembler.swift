//
//  DetailInfoAssembler.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

final class DetailInfoAssembler {
    
    static func assemble(with image: Image) -> DetailInfoController {
        let viewController = DetailInfoController(image: image)
        return viewController
    }
}
