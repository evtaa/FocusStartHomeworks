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
    
    enum Tabs {
        static let convertor = "Конвертор"
        static let listCurrency = "Ставки"
    }
    
    enum Auth {
        static let title = "Конвертор валют"
        static let enterUsername = "имя пользователя"
        static let enterPassword = "пароль"
        static let authorization = "Авторизация"
        static let registration = "Регистрация"
        static let showErrorAuth = "Неправильно введены имя пользователя или пароль"
        static let showErrorCoreData = "Ошибка CoreData: "
    }
    
    enum Converter {
        static let title = "Конвертор"
        static let copyToBuffer = "Копировать в буфер"
        static let showErrorInternet = "Ошибка сети: "
        static let dateOfActualRate = "Курс валюты актуален на: "
    }
    
    enum ListCurrency {
        static let  title = "Справка"
        static let minDateString = "2000-01-01"
        enum HeaderCell {
            static let  headerOfTable = "Выберите валюту"
        }
    }
    
    enum Rates {
        static let  title = "Ставки"
    }
}
