//
//  String.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 06.11.2021.
//

import Foundation

extension String {
    static var errorNotLocalized: String {
        return "error_not_localized"
    }

    func localized() -> String {
        let result = NSLocalizedString(
            self,
            tableName: nil,
            bundle: Bundle.main,
            value: .errorNotLocalized,
            comment: ""
        )
        if result == .errorNotLocalized {
            debugPrint("Error: String '\(self)' is not localized")
            return .errorNotLocalized
        }
        return result
    }
}
