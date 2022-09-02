//
//  Flag.swift
//  AniLease
//
//  Created by VironIT on 24.08.22.
//

import Foundation
import SwiftUI

struct SubFlag {
    var flag: String
    var flagName: UIImage!
}

class Flag {
    
    private var allFlag: [SubFlag] = []
    init(){
        allFlag.append(SubFlag(flag: "us", flagName: UIImage(named: "english")))
        allFlag.append(SubFlag(flag: "br", flagName: UIImage(named: "brazil")))
        allFlag.append(SubFlag(flag: "mx", flagName: UIImage(named: "mexico")))
        allFlag.append(SubFlag(flag: "es", flagName: UIImage(named: "spanish")))
        allFlag.append(SubFlag(flag: "sa", flagName: UIImage(named: "arabic")))
        allFlag.append(SubFlag(flag: "fr", flagName: UIImage(named: "franch")))
        allFlag.append(SubFlag(flag: "de", flagName: UIImage(named: "german")))
        allFlag.append(SubFlag(flag: "it", flagName: UIImage(named: "italian")))
        allFlag.append(SubFlag(flag: "ru", flagName: UIImage(named: "russian")))
        allFlag.append(SubFlag(flag: "jp", flagName: UIImage(named: "japanese")))
        allFlag.append(SubFlag(flag: "pt", flagName: UIImage(named: "portuguese")))
        allFlag.append(SubFlag(flag: "pl", flagName: UIImage(named: "polish")))
        allFlag.append(SubFlag(flag: "nl", flagName: UIImage(named: "datch")))
        allFlag.append(SubFlag(flag: "no", flagName: UIImage(named: "norwegian")))
        allFlag.append(SubFlag(flag: "fi", flagName: UIImage(named: "finnish")))
        allFlag.append(SubFlag(flag: "tr", flagName: UIImage(named: "turkish")))
        allFlag.append(SubFlag(flag: "se", flagName: UIImage(named: "swedish")))
        allFlag.append(SubFlag(flag: "gr", flagName: UIImage(named: "greek")))
        allFlag.append(SubFlag(flag: "il", flagName: UIImage(named: "hebrew")))
        allFlag.append(SubFlag(flag: "ro", flagName: UIImage(named: "romanian")))
        allFlag.append(SubFlag(flag: "id", flagName: UIImage(named: "indonesian")))
        allFlag.append(SubFlag(flag: "th", flagName: UIImage(named: "thai")))
        allFlag.append(SubFlag(flag: "kr", flagName: UIImage(named: "korean")))
        allFlag.append(SubFlag(flag: "dk", flagName: UIImage(named: "danish")))
        allFlag.append(SubFlag(flag: "cn", flagName: UIImage(named: "chinese")))
        allFlag.append(SubFlag(flag: "vn", flagName: UIImage(named: "vietnamese")))
        allFlag.append(SubFlag(flag: "ua", flagName: UIImage(named: "ukrainian")))
        allFlag.append(SubFlag(flag: "hu", flagName: UIImage(named: "hungarian")))
        allFlag.append(SubFlag(flag: "cz", flagName: UIImage(named: "czech")))
        allFlag.append(SubFlag(flag: "hr", flagName: UIImage(named: "croatian")))
        allFlag.append(SubFlag(flag: "my", flagName: UIImage(named: "malaysian")))
        allFlag.append(SubFlag(flag: "ph", flagName: UIImage(named: "filipino")))
    }
    
    func getFlagElement(text: String) -> [SubFlag] {
        var flag: [SubFlag] = []
        allFlag.forEach {
            if text.contains($0.flag) {
                flag.append($0)
            }
        }
        return flag
    }
    
}
