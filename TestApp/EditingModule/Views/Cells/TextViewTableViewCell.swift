//
//  TextViewTableViewCell.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 01.02.23.
//

import UIKit

protocol NameTextViewProtocol: AnyObject {
    func changeSize()
}

final class TextViewTableViewCell: UITableViewCell {
    
    static let idTextViewCell = "idTextViewCell"
    
    weak var nameTextViewDelegate: NameTextViewProtocol?
    
    private let nameLabel = UILabel()
    
    private let nameTextView = NameTextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        textViewDidChange(nameTextView)
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        nameLabel.font = Resources.Fonts.avenirNextRegular(size: 18)
        addView(nameLabel)
        contentView.addView(nameTextView)
        nameTextView.delegate = self
    }
    
    func configure(name: String, scrollEnable: Bool) {
        nameLabel.text = name
        nameTextView.isScrollEnabled = scrollEnable
    }
}

//MARK: - TextViewDelegate

extension TextViewTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        contentView.heightAnchor.constraint(equalTo: nameTextView.heightAnchor, multiplier: 1).isActive = true
        nameTextViewDelegate?.changeSize()
}
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите текст"
            textView.textColor = .black
        }
    }
}

//MARK: - Set Constraints

extension TextViewTableViewCell {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            nameTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            nameTextView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
