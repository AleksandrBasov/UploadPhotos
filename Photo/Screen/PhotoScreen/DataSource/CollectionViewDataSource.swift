//
//  CollectionViewDataSource.swift
//  Photo
//
//  Created by Александр Басов on 12/31/21.
//

import UIKit

class CollectionViewDataSource: NSObject {

    // - CollectionView
    private var collectionView: UICollectionView
    
    // - Data
    var images: [UIImage?] = []
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        configure()
    }
}

//MARK: - UITableViewDataSource
extension CollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}

//MARK: - UITableViewDelegate
extension CollectionViewDataSource: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseID, for: indexPath) as! PhotoCollectionViewCell
        cell.photoImageView.image = images[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
}

//MARK: - Configure
private extension CollectionViewDataSource {
    
    func configure() {
        registerCells()
        setupDataSource()
    }
    
    func setupDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCells() {
        collectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseID)
    }
    
}

