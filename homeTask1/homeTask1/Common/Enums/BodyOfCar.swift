//
//  BodyOfCar.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 06.11.2021.
//

import Foundation

enum BodyOfCar: String, CaseIterable {
    case sedan
    case hatchback
    case universal
    case coupe
    
    var rawValue: String {
            switch self {
            case .sedan: return Text.sedan
            case .hatchback: return Text.hatchback
            case .universal: return Text.universal
            case .coupe: return Text.coupe
            }
        }
    
    public func equal(bodyOfCarForPickerView: BodyOfCarForPickerView) -> Bool {
        switch self {
        case .sedan:
            return bodyOfCarForPickerView == .sedan
        case .hatchback:
            return bodyOfCarForPickerView == .hatchback
        case .universal:
            return bodyOfCarForPickerView == .universal
        case .coupe:
            return bodyOfCarForPickerView == .coupe
        }
    }
}
