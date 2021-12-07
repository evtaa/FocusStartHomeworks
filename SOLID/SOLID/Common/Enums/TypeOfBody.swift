//
//  TypeOfBody.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import UIKit

enum TypeOfBody: Equatable {
    case sedan(Int, UIImage, Bool)
    case hatchBack (Int, UIImage, Bool)
    case coupe (Int, UIImage, Bool)
    case universal (Int, UIImage, Bool)
    
    var rawValue: (name: String, cost: Int, image: UIImage, isEnabled: Bool) {
        switch self {
        case .sedan(let cost, let image, let isEnabled):
            return ("Седан", cost, image, isEnabled)
        case .hatchBack(let cost, let image, let isEnabled):
            return ("Хэтчбэк", cost, image, isEnabled)
        case .coupe(let cost, let image, let isEnabled):
            return ("Купе", cost, image, isEnabled)
        case .universal(let cost, let image, let isEnabled):
            return ("Универсал", cost, image, isEnabled)
        }
    }
}
