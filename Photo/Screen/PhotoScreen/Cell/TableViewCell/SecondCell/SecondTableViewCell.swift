//
//  SecondTableViewCell.swift
//  Photo
//
//  Created by Александр Басов on 12/30/21.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var lovationTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // - Delegate
    weak var delegate: PhotoDelegate?
    
    // - ViewModel
    private let viewModel = PhotoViewModel()
    
    // - DataSource
    private var dataSource: CollectionViewDataSource?
    
    // - Register Cell
    static let reuseID = "SecondTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SecondTableViewCell",
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configureCell(images: [UIImage?]) {
        dataSource?.images = images
        collectionView.reloadData()
    }
    
    @IBAction func addPhotoButton(_ sender: UIButton) {
        self.delegate?.presentPickerController()
    }
}

//MARK: - TextFieldDelegate
extension SecondTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        lovationTextField.endEditing(true)
        UserDefaults.standard.set(lovationTextField.text, forKey: "text")
        return true
    }
}

// MARK: - Configure
private extension SecondTableViewCell {
  
    func configure() {
        configureDataSource()
        configureCell()
        configureTF()
    }
    
    func configureTF() {
        lovationTextField.delegate = self
        lovationTextField.text = UserDefaults.standard.value(forKey: "text") as? String
    }
    
    func configureCell() {
        collectionView.backgroundColor = UIColor.clear
        shadowView.addShadow()
        addPhotoButton.addShadow()
    }
    
    func configureDataSource() {
        dataSource = CollectionViewDataSource(collectionView: collectionView)
    }

}
