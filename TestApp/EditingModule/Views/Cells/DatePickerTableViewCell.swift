//
//  DatePickerTableViewCell.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 02.02.23.
//

import UIKit

final class DatePickerTableViewCell: UITableViewCell {
    
    static let idDatePickerCell = "idDatePickerCell"
    
    private let nameLabel = UILabel()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.subviews[0].subviews[0].subviews[0].alpha = 0
        return datePicker
    }()
    
    
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
        contentView.addView(datePicker)
    }
    
    func configure(name: String, date: Date) {
        nameLabel.text = name
        datePicker.date = date
    }
    
    func getCellValue() -> String {
        if datePicker.date.getStringFromData() == Date().getStringFromData() {
            return ""
        } else {
            return datePicker.date.getStringFromData()
        }
    }
}

//MARK: - Set Constraints

extension DatePickerTableViewCell {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
}
