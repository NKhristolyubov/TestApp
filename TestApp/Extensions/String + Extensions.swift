//
//  String + Extensions.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 07.02.23.
//

import Foundation

extension String {
    func getDataFromString() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.date(from: self) ?? Date()
        return dateString
    }
}
