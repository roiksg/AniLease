//
//  MainCollectionViewCell.swift
//  AniLease
//
//  Created by VironIT on 18.08.22.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {

    // MARK: IBOutlet
    
    @IBOutlet weak private var titleImage: UIImageView!
    
    @IBOutlet weak private var titleName: UILabel!
    
    @IBOutlet weak private var animeEpisod: UILabel!
    
    @IBOutlet weak private var eraiRawsEpisod: UILabel!
    
    @IBOutlet weak private var subsPleaseEpisod: UILabel!
    
    private var releaseID: Int?
    
    static let identifiers = "releaseCell"
    
    var segue: (() -> ())?
    
    // MARK:  OVERRIDE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.tapToLabelCell))
        self.addGestureRecognizer(touch)
        // Initialization code
    }
    
    // MARK:  FUNC
    
    @objc func tapToLabelCell () {
        segue!()
    }
    
    func configureXib(_ releaseMainModel: ReleaseMainModel) {
        self.releaseID = releaseMainModel.ID
        titleName.text = releaseMainModel.name
        animeEpisod.text = releaseMainModel.Episod
        eraiRawsEpisod.text = releaseMainModel.lastER
        subsPleaseEpisod.text = releaseMainModel.lastSP
        let url = URL(string: releaseMainModel.image)
        titleImage.kf.setImage(with: url)
    }

}
