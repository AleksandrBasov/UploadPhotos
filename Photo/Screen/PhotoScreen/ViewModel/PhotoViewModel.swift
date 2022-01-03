//
//  PhotoViewModel.swift
//  Photo
//
//  Created by Александр Басов on 12/30/21.
//

import UIKit

class PhotoViewModel {
    
    // - Data
    var cellCount = 1
    var imageUrls: [String] = []
    var images: [UIImage?] = []
    
    // - Manager
    private let network = NetworkManager.shared
    
    // - Delegate
    weak var delegate: PhotoDelegate?
    
    func getPhoto() {
        imageUrls.forEach { url in
            network.getPhoto(url: url) { image in
                self.images.append(image)
                self.delegate?.dataIsNotEmpty()
            } onError: { error in
                self.delegate?.showError(text: error)
            }
        }
    }
}
