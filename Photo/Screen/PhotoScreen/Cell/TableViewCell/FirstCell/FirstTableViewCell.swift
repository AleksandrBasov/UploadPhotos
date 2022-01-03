//
//  FirstTableViewCell.swift
//  Photo
//
//  Created by Александр Басов on 12/30/21.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var shadowView: UIView!
    
    // - Register Cell
    static let reuseID = "FirstTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "FirstTableViewCell",
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}


// MARK: - Configure
private extension FirstTableViewCell {
  
    func configure() {
        shadowView.addShadow()
    }
}
