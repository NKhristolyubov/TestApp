//
//  NameTextView.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 01.02.23.
//

import UIKit

class NameTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super .init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        text = "Введите данные"
        font = Resources.Fonts.avenirNextRegular(size: 18)
        textColor = .lightGray
        textAlignment = .right
        isScrollEnabled = false
    }
}
