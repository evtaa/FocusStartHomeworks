//
//  Observable.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 27.11.2021.
//

import Foundation

class Observable<T> {
    var data: T {
        didSet {
            self.notify?(self.data)
        }
    }

    private var notify: ((T) -> Void)?

    init(_ data: T) {
        self.data = data
    }

    func setNotify(notify: @escaping ((T) -> Void)) {
        self.notify = notify
        self.notify?(self.data)
    }
}
