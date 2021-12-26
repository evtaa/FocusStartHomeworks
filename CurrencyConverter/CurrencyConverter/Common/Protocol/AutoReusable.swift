//
//  AutoReusable.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import Foundation

// MARK: - AutoReusable
protocol AutoReusable {
    static var autoReuseIdentifier: String { get }
}

extension AutoReusable {
    static var autoReuseIdentifier: String {
        String(describing: self)
    }
}
