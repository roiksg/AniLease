//
//  FlagCollectionViewCell.swift
//  AniLease
//
//  Created by VironIT on 2.09.22.
//

import UIKit

class FlagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    static let identifier = "flagCVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureXib (_ flag: SubFlag) {
        flagImage.image = flag.flagName
    }

}
