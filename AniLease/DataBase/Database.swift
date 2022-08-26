//
//  Database.swift
//  AniLease
//
//  Created by VironIT on 24.08.22.
//

import Foundation
import RealmSwift

class DataBase {
    private var LCItem: [LiveChartRSS] = []
    private var ERItem: [EraiRawsRSS] = []
    private var LCParser = LiveChartParserXML()
    private var ERParser = EraiRawsParserXML()
    private var LiveChartURL = "https://www.livechart.me/feeds/episodes"
    private var EraiRawsURL = "https://www.erai-raws.info/feed/?res=1080p&type=torrent&0879fd62733b8db8535eb1be24e23f6d"
    private var SubsPleaseURl = "https://subsplease.org/rss/?t&r=1080"
    
    func updateAnime(_ closure: @escaping(() -> Void)) {
        guard let url = URL(string: LiveChartURL) else {return}
        LCParser.getLiveChartItem(url) { (item) in
            DispatchQueue.main.async {
                let realm = try! Realm()
                let anime = realm.objects(Anime.self)
                self.LCItem = item
                self.LCItem.forEach { curent in
                    let obj = anime.where {
                        $0.link == curent.link
                    }.first
                    if obj == nil {
                        try! realm.write {
                            let newAnime = Anime()
                            newAnime.id = newAnime.IncrementaID()
                            newAnime.titleName = curent.title
                            newAnime.link = curent.link
                            newAnime.image = curent.imageURL
                            newAnime.pubDate = curent.pubDate
                            newAnime.category = curent.category
                            let newEpisods = AnimeEpisods()
                            newEpisods.id = newEpisods.IncrementaID()
                            newEpisods.pubDate = curent.pubDate
                            newEpisods.episods = curent.episods
                            newAnime.episod.append(newEpisods)
                            realm.add(newEpisods)
                            realm.add(newAnime)
                        }
                    }
                    else {
                        let episods = realm.objects(AnimeEpisods.self)
                        let strParser = StringParser()
                        var eps = episods.where {
                            $0.episods == curent.episods
                        }.first
                        if eps == nil {
                            eps = AnimeEpisods()
                            eps!.id = eps!.IncrementaID()
                        }
                        try! realm.write {
                            eps!.episods = curent.episods
                            eps!.pubDate = curent.pubDate
                            realm.add(eps!)
                            obj!.titleName = curent.title
                            obj!.image = curent.imageURL
                            obj!.pubDate = curent.pubDate
                            obj!.link = curent.link
                            if obj!.episod.last?.episods !=  strParser.strEpisodNumber(eps!.episods){
                                obj!.episod.append(eps!)
                            }
                            realm.add(eps!)
                            realm.add(obj!)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                closure()
            }
        }
    }
    
    func updateEraiRaws() {
        
        let realm = try! Realm()
        let eraiRaws = realm.objects(EraiRaws.self)
        guard let url = URL(string: EraiRawsURL) else {return}
        ERParser.getEraiRawsItem(url) { (item) in
            
            DispatchQueue.main.async {
                
                self.ERItem = item
                self.ERItem.forEach { curent in
                    
                    let obj = eraiRaws.where {
                        $0.titleName == curent.title
                    }.first
                    
                    if obj == nil {
                        try! realm.write {
                            
                            let newEraiRaws = EraiRaws()
                            newEraiRaws.id = newEraiRaws.IncrementaID()
                            newEraiRaws.titleName = curent.title
                            let newEREpisods = EraiRawsEpisods()
                            newEREpisods.pubDate = curent.pubDate
                            newEREpisods.episods = curent.episods
                            newEREpisods.subtitles = curent.subtitles
                            newEraiRaws.episods.append(newEREpisods)
                            realm.add(newEREpisods)
                            realm.add(newEraiRaws)
                            self.connectERToAnime(newEraiRaws, newEREpisods)
                        }
                    }
                    
                    else {
                        let episods = realm.objects(EraiRawsEpisods.self)
                        var newEp: Bool = false
                        var eps = episods.where {
                            $0.episods == curent.episods
                        }.first
                        if eps == nil {
                            eps = EraiRawsEpisods()
                            newEp = true
                        }
                        try! realm.write {
                            eps!.episods = curent.episods
                            eps!.subtitles = curent.subtitles
                            eps!.pubDate = curent.pubDate
                            obj!.titleName = curent.title
                            if newEp {
                                obj!.episods.append(eps!)
                            }
                            realm.add(eps!)
                            realm.add(obj!)
                        }
                    }
                }
            }
        }
    }
    
    func updateSubsPlease() {
        let realm = try! Realm()
        let sabsPlease = realm.objects(SubsPlease.self)
        guard let url = URL(string: SubsPleaseURl) else {return}
        ERParser.getEraiRawsItem(url) { (item) in
            
            DispatchQueue.main.async {
                
                self.ERItem = item
                self.ERItem.forEach { curent in
                    let obj = sabsPlease.where {
                        $0.titleName == curent.title
                    }.first
                    if obj == nil {
                        try! realm.write {
                            let newSubsPlease = SubsPlease()
                            newSubsPlease.id = newSubsPlease.IncrementaID()
                            newSubsPlease.titleName = curent.title
                            let newSPEpisods = SubsPleaseEpisods()
                            newSPEpisods.pubDate = curent.pubDate
                            newSPEpisods.episods = curent.episods
                            newSubsPlease.episods.append(newSPEpisods)
                            realm.add(newSPEpisods)
                            realm.add(newSubsPlease)
                            self.connectSPToAnime(newSubsPlease, newSPEpisods)
                        }
                    }
                    
                    else {
                        
                        let episods = realm.objects(SubsPleaseEpisods.self)
                        var newEp = false
                        var eps = episods.where {
                            $0.episods == curent.episods
                        }.first
                        
                        if eps == nil {
                            eps = SubsPleaseEpisods()
                            newEp = true
                        }
                        
                        try! realm.write {
                            eps!.episods = curent.episods
                            eps!.pubDate = curent.pubDate
                            obj!.titleName = curent.title
                            if newEp {
                                obj!.episods.append(eps!)
                            }
                            realm.add(eps!)
                            realm.add(obj!)
                        }
                    }
                }
            }
        }
    }
    
    func connectERToAnime (_ er: EraiRaws, _ episod: EraiRawsEpisods) {
        let realm = try! Realm()
        let anime = realm.objects(Anime.self)
        let curentAnime = anime.where {
            $0.titleName == er.titleName || $0.ERName == er.titleName
        }.first
        if curentAnime != nil {
            try! realm.write {
                curentAnime?.episod.last?.ERE = episod
                curentAnime?.ERName = er.titleName
                realm.add(curentAnime!)
            }
        }
    }
    
    func connectSPToAnime (_ sp: SubsPlease, _ episod: SubsPleaseEpisods) {
        let realm = try! Realm()
        let anime = realm.objects(Anime.self)
        let curentAnime = anime.where {
            $0.titleName == sp.titleName || $0.SPName == sp.titleName
        }.first
        if curentAnime != nil {
            try! realm.write {
                curentAnime!.episod.last?.SPE = episod
                curentAnime!.SPName = sp.titleName
                realm.add(curentAnime!)
            }
        }
    }
    
    func getEpisod(_ id: Int) -> [AnimeEpisods] {
        let realm = try! Realm()
        let anime = realm.objects(Anime.self)
        let curentAnime = anime.where{
            $0.id == id
        }.first
        let episod: [AnimeEpisods] = Array(curentAnime!.episod)
        return episod
    }
    
    func getInfoModel(_ id: Int) -> [Info] {
        let realm = try! Realm()
        var info: [Info] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        let anime = realm.objects(Anime.self)
        let curentAnime = anime.where{
            $0.id == id
        }.first
        let episods = curentAnime?.episod
        episods?.forEach {
            
            var date: String
            var eraiRawsEpisodInfo: EraiRawsEpisodInfo
            var subsPleaseEpisodInfo: SubsPleaseEpisodInfo
            if $0.ERE == nil {
                eraiRawsEpisodInfo = EraiRawsEpisodInfo(pubDate: "Non", status: "Non", Episod: "", subtitles: "")
            }
            else {
                date = dateFormatter.string(from: $0.ERE!.pubDate)
                eraiRawsEpisodInfo = EraiRawsEpisodInfo(pubDate: date, status: "Good", Episod: $0.ERE!.episods, subtitles: $0.ERE!.subtitles)
            }
            if $0.SPE == nil {
                subsPleaseEpisodInfo = SubsPleaseEpisodInfo(pubDate: "Non", episod: "", status: "Non")
            }
            else {
                date = dateFormatter.string(from: $0.SPE!.pubDate)
                subsPleaseEpisodInfo = SubsPleaseEpisodInfo(pubDate: date, episod: $0.SPE!.episods, status: "Good")
            }
            
            let episodInfo = EpisodInfo(episod: $0.episods, pubdate: $0.pubDate)
            info.append(Info(episod: episodInfo, eraiRaws: eraiRawsEpisodInfo, subsPlease: subsPleaseEpisodInfo))
        }
        return info
    }
}
