//
//  EpisodCollectionViewCell.swift
//  AniLease
//
//  Created by VironIT on 30.08.22.
//

import UIKit

class EpisodCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var type: UILabel!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var lastEpisod: UILabel!
    @IBOutlet private weak var date: UILabel!
    static let identifier = "EpisodCVC"
    var closure: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.tapToCell))
        self.addGestureRecognizer(touch)
        // Initialization code
    }
    
    @objc func tapToCell () {
        closure!()
    }
    
    func configureXib(_ type: String, _ title: String, _ lastEp: String, _ pubDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        self.type.text = type
        self.title.text = title
        self.lastEpisod.text = lastEp
        self.date.text = dateFormatter.string(from: pubDate)
    }

}
