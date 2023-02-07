//
//  PickerViewTableViewCell.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 02.02.23.
//

import UIKit

final class PickerViewTableViewCell: UITableViewCell {
    
    static let idPickerViewCell = "idPickerViewCell"
    
    private let nameLabel = UILabel()
    
    private let genderTextField = GenderTextField()
    
    private let genderPickerView = GenderPickerView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        nameLabel.font = Resources.Fonts.avenirNextRegular(size: 18)
        addView(nameLabel)
        genderTextField.inputView = genderPickerView
        contentView.addView(genderTextField)
        genderPickerView.genderDelegate = self
    }
    
    func configure(name: String, value: String) {
        nameLabel.text = name
    }
    
    func getCellValue() -> String {
        guard let text = genderTextField.text else { return "" }
        return text
    }
}

//MARK: - Set Constraints

extension PickerViewTableViewCell {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            genderTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            genderTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            genderTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            genderTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}

extension PickerViewTableViewCell: GenderPickerViewProtocol {
    func didSelect(row: Int) {
        genderTextField.text = Resources.Gender.allCases[row].rawValue
        genderTextField.resignFirstResponder()
    }
    
    
}

