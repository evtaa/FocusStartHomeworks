//
//  User.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import UIKit

final class UserModel {
    let uid: UUID
    private(set) var username: String
    private(set) var password: String
    
    init(username: String, password: String) {
        self.uid = UUID()
        self.username = username
        self.password = password
    }
    
    init(user: User) {
        self.uid = user.uid
        self.username = user.username
        self.password = user.password
    }
    
 }
