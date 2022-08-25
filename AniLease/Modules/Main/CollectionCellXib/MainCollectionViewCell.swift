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
    
    @IBOutlet weak private var titleJpEnName: UILabel!
    
    @IBOutlet weak private var episod: UILabel!
    
    @IBOutlet weak private var days: UILabel!
    
    @IBOutlet weak private var hours: UILabel!
    
    @IBOutlet weak private var minutes: UILabel!
    
    @IBOutlet weak private var seconds: UILabel!
    
    private var timer: Timer?
    
    private var globalTime: Int = 0
    
    private var releaseID: Int?
    
    static let identifiers = "releaseCell"
    
    var segue: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.tapToLabelCell))
        self.addGestureRecognizer(touch)
        // Initialization code
    }
    
    @objc func tapToLabelCell () {
        segue!()
        print("tap")
    }
    
    @objc private func timerInterval() {
        globalTime -= 1
        let (dd, hh, mm , ss) = getTime(time: globalTime)
        
        if days.text != String(dd) {
            days.text = String(dd)
        }
        if hours.text != String(hh) {
            hours.text = String(hh)
        }
        if minutes.text != String(mm) {
            minutes.text = String(mm)
        }
        seconds.text = String(ss)
    }
    
    func configureXib(_ releaseMainModel: ReleaseMainModel) {
        if releaseMainModel.time != 0 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerInterval), userInfo: nil, repeats: true)
        }
        self.releaseID = releaseMainModel.ID
        globalTime = releaseMainModel.time
        let (dd, hh, mm , ss) = getTime(time: globalTime)
        
        titleName.text = releaseMainModel.name
        episod.text = releaseMainModel.Episod
        let url = URL(string: releaseMainModel.image)
        titleImage.kf.setImage(with: url)
        self.days.text = String(dd)
        self.hours.text = String(hh)
        self.minutes.text = String(mm)
        self.seconds.text = String(ss)
    }
    
    private func getTime (time: Int) -> (Int, Int, Int, Int) {
        var value = time
        
        let days = value / 86400
        value -= days * 86400
        
        let hours = value / 3600
        value -= hours * 3600
        
        let minutes = value / 60
        value -= minutes * 60
        
        return (days, hours, minutes, value)
    }
}
