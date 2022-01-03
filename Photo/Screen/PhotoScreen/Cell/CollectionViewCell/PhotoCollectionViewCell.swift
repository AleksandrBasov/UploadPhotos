//
//  PhotoCollectionViewCell.swift
//  Photo
//
//  Created by Александр Басов on 12/30/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    // - UI
    @IBOutlet weak var photoImageView: UIImageView!
    
    // - Register Cell
    static let reuseID = "PhotoCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PhotoCollectionViewCell",
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}

// MARK: - Configure
private extension PhotoCollectionViewCell {
  
    func configure() {
        photoImageView.layer.cornerRadius = 15
    }
    
}
