//
//  EditingViewController.swift
//  TestApp
//
//  Created by Nikolai Khristoliubov on 01.02.23.
//

import UIKit
import PhotosUI

final class EditingViewController: UIViewController {
    
    private var userPhotoIsChanged = false
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let editingTableView = EditingTableView()
    private var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        addTaps()
    }
    
    override func viewWillLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    init(userModel: UserModel, userPhoto: UIImage?) {
        self.userModel = userModel
        self.userPhotoImageView.image = userPhoto
        super .init(nibName: nil, bundle: nil) 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        title = "Просмотр"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(saveTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem.createCastomButton(vc: self, selector: #selector(backButtonTapped))
        view.addView(userPhotoImageView)
        view.addView(editingTableView)
        editingTableView.setUserModel(model: userModel)
    }
    
    @objc private func backButtonTapped() {
        
        let editUserModel = editingTableView.getUserModel()
        
        if authFields(model: editUserModel) == false {
            presentSimpleAlert(title: "Ошибка", message: "Необходимо заполнить поля: фамилия, имя, дата рождения, пол")
            return
        }
        
        if editUserModel == userModel && userPhotoIsChanged == false {
            navigationController?.popViewController(animated: true)
        } else {
            presentChangeAlert { [weak self] value in
                guard let self = self else { return }
                if value {
                    guard let firstVC = self.navigationController?.viewControllers.first as? MainViewController else { return }
                    firstVC.changeUserModel(model: editUserModel)
                    firstVC.changeUserPhoto(image: self.userPhotoImageView.image)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @objc private func saveTapped() {
        
        let editUserModel = editingTableView.getUserModel()
        if authFields(model: editUserModel) {
            presentSimpleAlert(title: "Выполнено", message: "Все обязательные поля заполнены")
        } else {
            presentSimpleAlert(title: "Ошибка", message: "Необходимо заполнить поля: фамилия, имя, дата рождения, пол")
        }
    }
    
    private func authFields(model: UserModel) -> Bool {
        if model.firstName == "Введите данные" ||
            model.firstName == "" ||
            model.secondName == "Введите данные" ||
            model.secondName == "" ||
            model.birthsday == "Введите данные" ||
            model.gender == "" ||
            model.gender == "Не указан" {
            return false
        } else {
            return true
        }
    }
    
    private func addTaps() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
        userPhotoImageView.isUserInteractionEnabled = true
        userPhotoImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc private func setUserPhoto() {
        if #available(iOS 14.0, *) {
            presentPHPicker()
        } else {
            presentImagePicker()
        }
    }
}

//MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension EditingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func presentImagePicker() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        userPhotoImageView.image = image
        userPhotoIsChanged = true
        dismiss(animated: true)
    }
}

//MARK: - PHPickerViewControllerDelegate

@available(iOS 14.0, *)
extension EditingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.userPhotoImageView.image = image
                }
                self.userPhotoIsChanged = true
            }
        }
    }
    
    private func presentPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images])
        
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
    
    
}

//MARK: - Set Constraints

extension EditingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            editingTableView.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 10),
            editingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            editingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            editingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

