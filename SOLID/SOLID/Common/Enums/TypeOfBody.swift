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
    
    public func equal(selectTypeOfBody: SelectTypeOfBody) -> Bool {
        switch self {
        case .sedan( _, _, _):
            return selectTypeOfBody == .sedan
        case .hatchBack( _, _, _):
            return selectTypeOfBody == .hatchBack
        case .universal( _, _, _):
            return selectTypeOfBody == .universal
        case .coupe( _, _, _):
            return selectTypeOfBody == .coupe
        }
    }
    
    public func createTypeOfBodyWithToggleIsEnabled() -> TypeOfBody {
        switch self {
        case .sedan(let cost, let image, let isEnabled):
            return TypeOfBody.sedan(cost, image, !isEnabled)
        case .coupe(let cost, let image, let isEnabled):
            return TypeOfBody.coupe(cost, image, !isEnabled)
        case .hatchBack(let cost, let image, let isEnabled):
            return TypeOfBody.hatchBack(cost, image, !isEnabled)
        case .universal(let cost, let image, let isEnabled):
            return TypeOfBody.universal(cost, image, !isEnabled)
        }
    }
    
    public func createTypeOfBodyWithFalseIsEnabled() -> TypeOfBody {
        switch self {
        case .sedan(let cost, let image, _):
            return TypeOfBody.sedan(cost, image, false)
        case .coupe(let cost, let image, _):
            return TypeOfBody.coupe(cost, image, false)
        case .hatchBack(let cost, let image, _):
            return TypeOfBody.hatchBack(cost, image, false)
        case .universal(let cost, let image, _):
            return TypeOfBody.universal(cost, image, false)
        }
    }
    
    public func getSelectTypeOfBody() -> SelectTypeOfBody {
        switch self {
        case .sedan( _, _, _):
            return SelectTypeOfBody.sedan
        case .hatchBack( _, _, _):
            return SelectTypeOfBody.hatchBack
        case .universal( _, _, _):
            return SelectTypeOfBody.universal
        case .coupe( _, _, _):
            return SelectTypeOfBody.coupe
        }
    }
}
