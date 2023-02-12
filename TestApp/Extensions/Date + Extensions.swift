//
//  Date + Extensions.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 07.02.23.
//

import Foundation

extension Date {
    
    func getStringFromData() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: self)
        return date
    }
}
