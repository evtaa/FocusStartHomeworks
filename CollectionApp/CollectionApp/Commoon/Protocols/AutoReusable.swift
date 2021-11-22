//
//  AutoReusable.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
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
