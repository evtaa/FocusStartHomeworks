//
//  AutoReusable.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 12.11.2021.
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
