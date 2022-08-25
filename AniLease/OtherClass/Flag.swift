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
    var flagName: Image
}

class Flag {
    
    var flag: [SubFlag]!
    init(){
        flag.append(SubFlag(flag: "us", flagName: Image("english")))
        flag.append(SubFlag(flag: "br", flagName: Image("brazil")))
        flag.append(SubFlag(flag: "mx", flagName: Image("mexico")))
        flag.append(SubFlag(flag: "es", flagName: Image("spanish")))
        flag.append(SubFlag(flag: "sa", flagName: Image("arabic")))
        flag.append(SubFlag(flag: "fr", flagName: Image("franch")))
        flag.append(SubFlag(flag: "de", flagName: Image("german")))
        flag.append(SubFlag(flag: "it", flagName: Image("italian")))
        flag.append(SubFlag(flag: "ru", flagName: Image("russian")))
        flag.append(SubFlag(flag: "jp", flagName: Image("japanese")))
        flag.append(SubFlag(flag: "pt", flagName: Image("portuguese")))
        flag.append(SubFlag(flag: "pl", flagName: Image("polish")))
        flag.append(SubFlag(flag: "nl", flagName: Image("datch")))
        flag.append(SubFlag(flag: "no", flagName: Image("norwegian")))
        flag.append(SubFlag(flag: "fi", flagName: Image("finnish")))
        flag.append(SubFlag(flag: "tr", flagName: Image("turkish")))
        flag.append(SubFlag(flag: "se", flagName: Image("swedish")))
        flag.append(SubFlag(flag: "gr", flagName: Image("greek")))
        flag.append(SubFlag(flag: "il", flagName: Image("hebrew")))
        flag.append(SubFlag(flag: "ro", flagName: Image("romanian")))
        flag.append(SubFlag(flag: "id", flagName: Image("indonesian")))
        flag.append(SubFlag(flag: "th", flagName: Image("thai")))
        flag.append(SubFlag(flag: "kr", flagName: Image("korean")))
        flag.append(SubFlag(flag: "dk", flagName: Image("danish")))
        flag.append(SubFlag(flag: "cn", flagName: Image("chinese")))
        flag.append(SubFlag(flag: "vn", flagName: Image("vietnamese")))
        flag.append(SubFlag(flag: "ua", flagName: Image("ukrainian")))
        flag.append(SubFlag(flag: "hu", flagName: Image("hungarian")))
        flag.append(SubFlag(flag: "cz", flagName: Image("czech")))
        flag.append(SubFlag(flag: "hr", flagName: Image("croatian")))
        flag.append(SubFlag(flag: "my", flagName: Image("malaysian")))
        flag.append(SubFlag(flag: "ph", flagName: Image("filipino")))
    }
    
}
