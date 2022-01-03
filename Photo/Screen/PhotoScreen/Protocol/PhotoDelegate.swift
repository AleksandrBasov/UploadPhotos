//
//  PhotoDelegate.swift
//  Photo
//
//  Created by Александр Басов on 12/30/21.
//

import UIKit

protocol PhotoDelegate: AnyObject {
    func presentPickerController()
    func showError(text: String)
    func dataIsNotEmpty()
}
