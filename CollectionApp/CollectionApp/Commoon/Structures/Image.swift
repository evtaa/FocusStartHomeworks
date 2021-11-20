//
//  Image.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

struct Image {
    let id = NSUUID()
    let image: UIImage
    let name: String
    let info: String
}

extension Image: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Image, rhs: Image) -> Bool {
     lhs.id == rhs.id
    }
}
