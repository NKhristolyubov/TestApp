//
//  ViewController.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 01.02.23.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let maintableView = MainTableView()
    private var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        getUserModel()
        setValueArray()
    }
    
    override func viewWillLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }

    private func setupViews() {
        title = "Просмотр"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Редактировать",
            style: .plain,
            target: self,
            action: #selector(editingTapped))
        view.addView(userPhotoImageView)
        view.addView(maintableView)
    }
    
    @objc private func editingTapped() {
        let editingTableViewController = EditingViewController(userModel: userModel, userPhoto: userPhotoImageView.image)
        navigationController?.pushViewController(editingTableViewController, animated: true)
    }
    
    private func getValueArray() -> [String] {
        var valueArray = [String]()
        for key in Resources.NameFields.allCases {
            let value = UserDefaultsManager.getUserValue(key: key.rawValue)
            valueArray.append(value)
        }
        return valueArray
    }
    
    private func setValueArray() {
        let array = getValueArray()
        maintableView.setValueArray(array: array)
        maintableView.reloadData()
    }
    
    public func changeUserModel(model: UserModel) {
        saveEditModel(model: model)
        userModel = model
        setValueArray()
        //maintableView.reloadData()
    }
    
    private func getUserModel() {
        userModel = UserDefaultsManager.getUserModel()
        let userPhoto = UserDefaultsManager.loadUsetImage()
        userPhotoImageView.image = userPhoto
    }
    
    private func saveEditModel(model: UserModel) {
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.firstName.rawValue, value: model.firstName)
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.secondName.rawValue, value: model.secondName)
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.thirdName.rawValue, value: model.thirdName)
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.birthday.rawValue, value: model.birthsday)
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.gender.rawValue, value: model.gender)
    }
    
    public func changeUserPhoto(image: UIImage?) {
        userPhotoImageView.image = image
        guard let userPhoto = image else { return }
        UserDefaultsManager.saveUserPhoto(image: userPhoto)
    }
}

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            maintableView.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 10),
            maintableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            maintableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            maintableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

