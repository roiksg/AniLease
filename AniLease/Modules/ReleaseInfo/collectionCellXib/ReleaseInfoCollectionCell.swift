//
//  ReleaseInfoCollectionCell.swift
//  AniLease
//
//  Created by VironIT on 24.08.22.
//

import UIKit

class ReleaseInfoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var animeEpisod: UILabel!
    @IBOutlet weak var animeDate: UILabel!
    @IBOutlet weak var eraiRawsEpisod: UILabel!
    @IBOutlet weak var eraiRawsStatus: UILabel!
    @IBOutlet weak var eraiRawsDate: UILabel!
    @IBOutlet weak var subsPleaseEpisod: UILabel!
    @IBOutlet weak var subsPleaseStatus: UILabel!
    @IBOutlet weak var subsPleaseDate: UILabel!
    static let identifier = "EpisodsInfoCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureXib (_ info: Info) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        animeDate.text = dateFormatter.string(from: info.episod.pubdate)
        animeEpisod.text = info.episod.episod
        eraiRawsEpisod.text = info.eraiRaws.Episod
        eraiRawsStatus.text = info.eraiRaws.status
        eraiRawsDate.text = info.eraiRaws.pubDate
        subsPleaseEpisod.text = info.subsPlease.episod
        subsPleaseStatus.text = info.subsPlease.status
        subsPleaseDate.text = info.subsPlease.pubDate
    }

}
