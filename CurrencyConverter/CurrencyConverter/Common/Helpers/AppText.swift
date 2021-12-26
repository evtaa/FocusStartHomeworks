//
//  AppText.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 22.12.2021.
//

import Foundation

enum AppText {
    static let logout: String = "Выход"
    static let emptyString: String = ""
    static let done: String = "Done"
    static let back: String = "Back"
    
    enum Auth {
        static let enterUsername = "имя пользователя"
        static let enterPassword = "пароль"
        static let authorization = "Авторизация"
        static let registration = "Регистрация"
        static let showErrorAuth = "Неправильно введены имя пользователя или пароль"
        static let showErrorCoreData = "Ошибка CoreData: "
    }
    
}
