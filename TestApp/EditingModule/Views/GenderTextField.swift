//
//  GenderTextField.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 02.02.23.
//

import UIKit

class GenderTextField: UITextField {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        !isFirstResponder
    }
    
    private func configure() {
        textAlignment = .right
        tintColor = .clear
        font = Resources.Fonts.avenirNextRegular(size: 18)
        let font = Resources.Fonts.avenirNextRegular(size: 18)
        attributedPlaceholder = NSAttributedString(string: "Введите данные", attributes: [.foregroundColor : UIColor.lightGray, .font: font as Any])
    }
}
