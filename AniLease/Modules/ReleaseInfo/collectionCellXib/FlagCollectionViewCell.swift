//
//  FlagCollectionViewCell.swift
//  AniLease
//
//  Created by VironIT on 2.09.22.
//

import UIKit

class FlagCollectionViewCell: UICollectionViewCell {
    
    // MARK:  IBOutlet
    
    @IBOutlet weak var flagImage: UIImageView!
    static let identifier = "flagCVC"
    
    // MARK:  override

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK:  FUNC
    
    func configureXib (_ flag: SubFlag) {
        flagImage.image = flag.flagName
    }

}
