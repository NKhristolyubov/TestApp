//
//  Resources.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 01.02.23.
//

import UIKit

enum Resources {
    
    enum NameFields: String, CaseIterable {
        case firstName = "Имя"
        case secondName = "Фамилия"
        case thirdName = "Отчество"
        case birthday = "Дата рождения"
        case gender = "Пол"
    }
    
    enum Gender: String, CaseIterable {
        case noSpecified = "Не указан"
        case man = "Мужской"
        case woman = "Женский"
    }
    
    enum Fonts {
        static func avenirNextRegular(size: CGFloat) -> UIFont? {
            UIFont(name: "Avenir Next", size: size)
        }
    }
}
