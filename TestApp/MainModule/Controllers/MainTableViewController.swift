//
//  ViewController.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 01.02.23.
//

import UIKit

final class MainTableViewController: UITableViewController {
    
    private var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getUserModel()
//        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.idMainTableViewCell)
        tableView.register(type: MainTableViewCell.self)
        print(userModel)
    }

    private func setupViews() {
        title = "Просмотр"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Редактировать",
            style: .plain,
            target: self,
            action: #selector(editingTapped))
    }
    
    @objc private func editingTapped() {
        let editingTableViewController = EditingViewController(userModel)
        navigationController?.pushViewController(editingTableViewController, animated: true)
    }
    
    public func changeUserModel(model: UserModel) {
        saveEditModel(model: model)
        userModel = model
        tableView.reloadData()
    }
    
    private func getUserModel() {
        userModel = UserDefaultsManager.getUserModel()
    }
    
    private func saveEditModel(model: UserModel) {
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.firstName.rawValue, value: model.firstName)
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.secondName.rawValue, value: model.secondName)
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.thirdName.rawValue, value: model.thirdName)
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.birthday.rawValue, value: model.birthsday)
        UserDefaultsManager.saveUserValue(key: Resources.NameFields.gender.rawValue, value: model.gender)
    }
}

//MARK: - UITableViewDataSource

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.NameFields.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.idMainTableViewCell, for: indexPath) as? MainTableViewCell else { return UITableViewCell()}
        guard let cell = tableView.dequeReusableCell(type: MainTableViewCell.self) else { return UITableViewCell()}
        
        let nameField = Resources.NameFields.allCases[indexPath.row].rawValue
        let nameValue = UserDefaultsManager.getUserValue(key: nameField)
        cell.configure(name: nameField, value: nameValue)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}
