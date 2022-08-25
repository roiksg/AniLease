//
//  LiveChart.swift
//  AniLease
//
//  Created by VironIT on 24.08.22.
//

import Foundation
import RealmSwift


class Anime: Object {
    @Persisted var id: Int
    @Persisted var titleName: String
    @Persisted var link: String
    @Persisted var episodsCount: Int?
    @Persisted var pubDate: Date
    @Persisted var image: String
    @Persisted var refreshTime: Int?
    @Persisted var episod: List<AnimeEpisods>
    
    func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(Anime.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
}

class AnimeEpisods: Object {
    @Persisted var id: Int
    @Persisted var episods: String
    @Persisted var pubDate: Date
    @Persisted var ERE: EraiRaws?
    @Persisted var SPE: SubsPlease?
    
    func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(AnimeEpisods.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
}

class EraiRaws: Object {
    @Persisted var id: Int
    @Persisted var titleName: String
    @Persisted var episods: List<EraiRawsEpisods>
    
    func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(EraiRaws.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
}

class SubsPlease: Object {
    @Persisted var id: Int
    @Persisted var titleName: String
    @Persisted var episods: List<SubsPleaseEpisods>
    
    func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(SubsPlease.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
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


