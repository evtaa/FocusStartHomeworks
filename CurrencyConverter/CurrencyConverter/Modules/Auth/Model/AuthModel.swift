//
//  AuthModel.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import Foundation

protocol IAuthModel {
    func set(username: String)
    func getUsername() -> String?
    func set(password: String)
    func getPassword() -> String?
}

final class AuthModel {
    // MARK: - Properties
    private var username: String?
    private var password: String?
}

// MARK: - IModel
extension AuthModel: IAuthModel{
    func set(username: String) {
        self.username = username
    }
    
    func getUsername() -> String? {
        return username
    }
    
    func set(password: String) {
        self.password = password
    }
    
    func getPassword() -> String? {
        return password
    }
}
