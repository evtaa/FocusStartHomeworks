//
//  BaseViewController.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

class BaseViewController<ViewType: UIView>: UIViewController {
    
    var rootView: ViewType {
        self.view as? ViewType ?? ViewType()
    }
    
    override func loadView() {
        self.view = ViewType()
    }
}
