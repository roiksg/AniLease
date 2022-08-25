//
//  LiveChart.swift
//  AniLease
//
//  Created by VironIT on 24.08.22.
//

import Foundation
import RealmSwift


class Anime: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var titleName: String
    @Persisted var link: String
    @Persisted var episodsCount: Int
    @Persisted var pubDate: Date
    @Persisted var image: String
    @Persisted var refreshTime: Int
    @Persisted var episod: List<AnimeEpisods>
}

class AnimeEpisods: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var episods: String
    @Persisted var pubDate: Date
    @Persisted var ERE: EraiRaws
    @Persisted var SPE: SubsPlease
}

class EraiRaws: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var titleName: String
    @Persisted var episods: List<EraiRawsEpisods>
}

class SubsPlease: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var titleName: String
    @Persisted var episods: List<SubsPleaseEpisods>
}

class EraiRawsEpisods: Object {
    @Persisted var episods: String
    @Persisted var pubDate: Date
    @Persisted var subtitles: String
}

class SubsPleaseEpisods: Object {
    @Persisted var episods: String
    @Persisted var pubDate: Date
}


