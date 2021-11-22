//
//  BaseViewController.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
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
