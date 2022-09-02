//
//  ReleaseInfoCollectionCell.swift
//  AniLease
//
//  Created by VironIT on 24.08.22.
//

import UIKit

class ReleaseInfoCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var animeEpisod: UILabel!
    @IBOutlet private weak var animeDate: UILabel!
    @IBOutlet private weak var eraiRawsEpisod: UILabel!
    @IBOutlet private weak var eraiRawsStatus: UILabel!
    @IBOutlet private weak var eraiRawsDate: UILabel!
    @IBOutlet private weak var subsPleaseEpisod: UILabel!
    @IBOutlet private weak var subsPleaseStatus: UILabel!
    @IBOutlet private weak var subsPleaseDate: UILabel!
    @IBOutlet private weak var collectionFlag: UICollectionView!
    static let identifier = "EpisodsInfoCell"
    private var subtitles: [SubFlag] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionFlag.dataSource = self
        self.collectionFlag.delegate = self
        self.collectionFlag.register(.init(nibName: "FlagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FlagCollectionViewCell.identifier)
        // Initialization code
    }
    
    func configureXib (_ info: Info) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        animeDate.text = dateFormatter.string(from: info.episod.pubdate)
        animeEpisod.text = info.episod.episod
        eraiRawsEpisod.text = info.eraiRaws.Episod
        eraiRawsStatus.text = info.eraiRaws.status
        if info.eraiRaws.pubDate == nil {
            eraiRawsDate.text = ""
        }
        else {
            eraiRawsDate.text = dateFormatter.string(from: info.eraiRaws.pubDate!)
        }
        subsPleaseEpisod.text = info.subsPlease.episod
        subsPleaseStatus.text = info.subsPlease.status
        if info.subsPlease.pubDate == nil {
            subsPleaseDate.text = ""
        }
        else {
            subsPleaseDate.text = dateFormatter.string(from: info.subsPlease.pubDate!)
        }
        
        let flag = Flag()
        subtitles = flag.getFlagElement(text: info.eraiRaws.subtitles)
    }

}

extension ReleaseInfoCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subtitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: FlagCollectionViewCell.identifier, for: indexPath) as! FlagCollectionViewCell
        collectionCell.configureXib(subtitles[indexPath.row])
        return collectionCell
    }
}

extension ReleaseInfoCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 50, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
