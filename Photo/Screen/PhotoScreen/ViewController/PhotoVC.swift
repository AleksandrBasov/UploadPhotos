//
//  PhotoVC.swift
//  Photo
//
//  Created by Александр Басов on 12/30/21.
//

import UIKit
import Firebase

class PhotoVC: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    // - ViewModel
    private let viewModel = PhotoViewModel()
    
    // - DataSource
    private var dataSource: TableViewDataSource?
    
    // - Delegate
    weak var delegate: PhotoDelegate?
    
    // - Firebase
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // - Action
    @IBAction func addTableViewCell(_ sender: UIButton) {
        viewModel.cellCount += 1
        tableView.reloadData()
        checkAddButton()
    }
}


// MARK: - PhotoDelegate
extension PhotoVC: PhotoDelegate {
    
    func showError(text: String) {
        showAlert(message: text)
    }
    
    func dataIsNotEmpty() {
        if viewModel.cellCount == 2 {
            checkAddButton()
            tableView.reloadData()
        } else {
            checkAddButton()
            viewModel.cellCount += 1
            tableView.reloadData()
        }
    }
    
    func presentPickerController() {
        presentPicker()
    }
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PhotoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        guard let imageData = image.pngData() else { return }
        storage.child("images/\(viewModel.images.count).png").putData(imageData, metadata: nil, completion: nil)
        getUrl()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - getUrl, checkAddButton
private extension PhotoVC {
    
    func getUrl() {
        storage.child("images").listAll { (result, error) in
            result.items.forEach { (imageRef) in
                imageRef.downloadURL { url, error in
                    self.viewModel.imageUrls = []
                    self.viewModel.images = []
                    guard let url = url, error == nil else { return }
                    let urlString = url.absoluteString
                    self.viewModel.imageUrls.append(urlString)
                    self.viewModel.getPhoto()
                }
            }
        }
    }
    
    func checkAddButton() {
        addButton.isEnabled = viewModel.cellCount != 2
        addButton.backgroundColor = .lightGray
    }
}

// MARK: configure
private extension PhotoVC {
    
    func configure() {
        viewModel.delegate = self
        addShadow()
        configureDataSource()
        getUrl()
    }
    
    func addShadow() {
        locationLabel.addShadow()
        addButton.addShadow()
    }
    
    func configureDataSource() {
        dataSource = TableViewDataSource(tableView: tableView, viewModel: viewModel)
        dataSource?.delegate = self
    }
}

