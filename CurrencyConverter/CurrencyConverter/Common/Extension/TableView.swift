//
//  TableView.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import UIKit

extension UITableViewCell: AutoReusable {
}

extension UITableViewHeaderFooterView: AutoReusable {
}

extension UITableView {
    func register <T: UITableViewCell> (_ cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.autoReuseIdentifier)
    }
    
    func register <T: UITableViewHeaderFooterView> (_ cellType: T.Type) {
        self.register(cellType, forHeaderFooterViewReuseIdentifier: cellType.autoReuseIdentifier)
    }
    
    func dequeueReusableCell <T: UITableViewCell>(ofType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.autoReuseIdentifier, for: indexPath) as? T ?? T()
    }
    
    func dequeueReusableHeaderFooterCell <T: UITableViewHeaderFooterView>(ofType: T.Type) -> T {
        self.dequeueReusableHeaderFooterView(withIdentifier: T.autoReuseIdentifier) as? T ?? T()
    }
}
