//
//  ReleaseInfoCell.swift
//  AniLease
//
//  Created by VironIT on 26.08.22.
//

import Foundation

struct Info {
    var episod: EpisodInfo
    var eraiRaws: EraiRawsEpisodInfo
    var subsPlease: SubsPleaseEpisodInfo
}

struct EpisodInfo {
    var episod: String
    var pubdate: Date
}

struct EraiRawsEpisodInfo {
    var pubDate: Date?
    var status: String
    var Episod: String
    var subtitles: String
}

struct SubsPleaseEpisodInfo {
    var pubDate: Date?
    var episod: String
    var status: String
}
