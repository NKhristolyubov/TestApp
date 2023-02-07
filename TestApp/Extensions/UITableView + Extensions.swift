//
//  UITableView + Extensions.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 06.02.23.
//

import UIKit

extension UITableView {
    
    func register(type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(type, forCellReuseIdentifier: className)
    }
    
    func dequeReusableCell<T>(type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
