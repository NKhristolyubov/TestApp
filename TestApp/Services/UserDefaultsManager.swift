//
//  UserDefaultsManager.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 03.02.23.
//

import UIKit

class UserDefaultsManager {
    
    private static let defaults = UserDefaults.standard // точка доступа в UserDefaults
    private static let userSessionKey = "userKey"//пользовательский ключ
    
    //метод, который позволяет получить словарь, в котором хранятся данные
    static func getUserDictionary() -> [String : String] {
        defaults.value(forKey: userSessionKey) as? [String : String] ?? [:]
    }
    
    //метод, который будет добавлять в userDefaults или редактировать значение, внесенное пользователем в поле ввода
    static func saveUserValue(key: String, value: String) {
        var userDictionary = getUserDictionary()
        userDictionary[key] = value
        defaults.set(userDictionary, forKey: userSessionKey)
    }
    
    //преобразовываем полученные данные в модель и возвращаем их
    static func getUserModel() -> UserModel {
        var userModel = UserModel()
        let userDictionary = getUserDictionary()
        userModel.firstName = userDictionary[Resources.NameFields.firstName.rawValue] ?? ""
        userModel.secondName = userDictionary[Resources.NameFields.secondName.rawValue] ?? ""
        userModel.thirdName = userDictionary[Resources.NameFields.thirdName.rawValue] ?? ""
        userModel.birthsday = userDictionary[Resources.NameFields.birthday.rawValue] ?? ""
        userModel.gender = userDictionary[Resources.NameFields.gender.rawValue] ?? ""
        return userModel
    }
    
    //метод, который выдает значение по ключу
    
    static func getUserValue(key: String) -> String {
        let userDictionary = getUserDictionary()
        let userValue = userDictionary[key] ?? ""
        return userValue
    }
    
    static func saveUserPhoto(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        UserDefaultsManager.defaults.set(data, forKey: "userPhoto")
    }
    
    static func loadUsetImage() -> UIImage {
        guard let data = defaults.data(forKey: "userPhoto"),
              let image = UIImage(data: data) else {
            return UIImage()
        }
        return image
    }
}
