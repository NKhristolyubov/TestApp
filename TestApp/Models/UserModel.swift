//
//  UserModel.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 03.02.23.
//

import Foundation

struct UserModel {
    var firstName = ""
    var secondName = ""
    var thirdName = ""
    var birthsday = ""
    var gender = ""
    
    static func == (firstModel: UserModel, secondModel: UserModel) -> Bool {
        firstModel.firstName == secondModel.firstName &&
        firstModel.secondName == secondModel.secondName &&
        firstModel.thirdName == secondModel.thirdName &&
        firstModel.birthsday == secondModel.birthsday &&
        firstModel.gender == secondModel.gender 
    }
}
