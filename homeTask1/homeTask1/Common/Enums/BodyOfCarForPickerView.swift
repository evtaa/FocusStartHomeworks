//
//  BodyOfCarForPickerView.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 06.11.2021.
//

import Foundation

enum BodyOfCarForPickerView: String, CaseIterable {
    case every
    case sedan
    case hatchback
    case universal
    case coupe
    
    var rawValue: String {
            switch self {
            case .every: return Text.every
            case .sedan: return Text.sedan
            case .hatchback: return Text.hatchback
            case .universal: return Text.universal
            case .coupe: return Text.coupe
            }
        }
}
