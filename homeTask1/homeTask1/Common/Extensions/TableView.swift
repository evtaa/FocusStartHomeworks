//
//  TableView.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import Foundation
import UIKit

extension UITableViewCell: AutoReusable {
}

extension UITableView {
    func register <T: UITableViewCell> (_ cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.autoReuseIdentifier)
    }
    
    func dequeueReusableCell <T: UITableViewCell>(ofType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.autoReuseIdentifier, for: indexPath) as? T ?? T()
    }
}

// MARK: - AutoReusable
protocol AutoReusable {
    static var autoReuseIdentifier: String { get }
}

extension AutoReusable {
    static var autoReuseIdentifier: String {
        String(describing: self)
    }
}
