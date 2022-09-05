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
    private var SPItem: [SubsPleaseRSS] = []
    private var LCParser = LiveChartParserXML()
    private var ERParser = EraiRawsParserXML()
    private var SPParser = SubsPleaseParserXML()
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
                            let strParser = StringParser()
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
                            newEpisods.episods = strParser.strEpisodNumber(curent.episods)
                            newAnime.episod.append(newEpisods)
                            realm.add(newEpisods)
                            realm.add(newAnime)
                        }
                    }
                    else {
                        let episods = obj!.episod
                        let strParser = StringParser()
                        var eps = episods.where {
                            $0.episods == strParser.strEpisodNumber(curent.episods)
                        }.first
                        if eps == nil {
                            eps = AnimeEpisods()
                            eps!.id = eps!.IncrementaID()
                        }
                        try! realm.write {
                            eps!.episods = strParser.strEpisodNumber(curent.episods)
                            eps!.pubDate = curent.pubDate
                            realm.add(eps!)
                            obj!.titleName = curent.title
                            obj!.image = curent.imageURL
                            obj!.pubDate = curent.pubDate
                            obj!.link = curent.link
                            let secondEPS = obj!.episod.where {
                                $0.episods == eps!.episods
                            }.first
                            if secondEPS == nil{
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
                self.updateEraiRaws()
            }
        }
    }
    
    func updateEraiRaws() {
        
        let realm = try! Realm()
        let eraiRaws = realm.objects(EraiRaws.self)
        guard let url = URL(string: EraiRawsURL) else {return}
        ERParser.getEraiRawsItem(url) { (item) in
            
            DispatchQueue.main.async {
                
                let strParser = StringParser()
                self.ERItem = item
                self.ERItem.forEach { curent in
                    
                    let obj = eraiRaws.where {
                        $0.titleName == curent.title
                    }.first
                    
                    if obj == nil {
                        let newEraiRaws = EraiRaws()
                        let newEREpisods = EraiRawsEpisods()
                        try! realm.write {
                            
                            newEraiRaws.id = newEraiRaws.IncrementaID()
                            newEraiRaws.titleName = curent.title
                            
                            newEREpisods.pubDate = curent.pubDate
                            newEREpisods.episods = strParser.strEpisodNumber(curent.episods)
                            newEREpisods.subtitles = curent.subtitles
                            newEraiRaws.episods.append(newEREpisods)
                            realm.add(newEREpisods)
                            realm.add(newEraiRaws)
                        }
                        self.connectERToAnime(newEraiRaws, newEREpisods)
                    }
                    
                    else {
                        let episods = obj!.episods
                        var newEp: Bool = false
                        var eps = episods.where {
                            $0.episods == curent.episods
                        }.first
                        if eps == nil {
                            eps = EraiRawsEpisods()
                            newEp = true
                        }
                        try! realm.write {
                            eps!.episods = strParser.strEpisodNumber(curent.episods)
                            eps!.subtitles = curent.subtitles
                            eps!.pubDate = curent.pubDate
                            obj!.titleName = curent.title
                            if newEp {
                                obj!.episods.append(eps!)
                            }
                            realm.add(eps!)
                            realm.add(obj!)
                        }
                        self.connectERToAnime(obj!, eps!)
                    }
                }
                self.updateSubsPlease()
            }
        }
    }
    
    func updateSubsPlease() {
        let realm = try! Realm()
        let sabsPlease = realm.objects(SubsPlease.self)
        guard let url = URL(string: SubsPleaseURl) else {return}
        SPParser.getSubsPleaseItem(url) { (item) in
            
            DispatchQueue.main.async {
                
                let strParser = StringParser()
                self.SPItem = item
                self.SPItem.forEach { curent in
                    let obj = sabsPlease.where {
                        $0.titleName == curent.title
                    }.first
                    if obj == nil {
                        let newSubsPlease = SubsPlease()
                        let newSPEpisods = SubsPleaseEpisods()
                        try! realm.write {
                            
                            newSubsPlease.id = newSubsPlease.IncrementaID()
                            newSubsPlease.titleName = curent.title
                            
                            newSPEpisods.pubDate = curent.pubDate
                            newSPEpisods.episods = strParser.strEpisodNumber(curent.episods)
                            newSubsPlease.episods.append(newSPEpisods)
                            realm.add(newSPEpisods)
                            realm.add(newSubsPlease)
                            
                        }
                        self.connectSPToAnime(newSubsPlease, newSPEpisods)
                    }
                    
                    else {
                        
                        let episods = obj!.episods
                        var newEp = false
                        var eps = episods.where {
                            $0.episods == curent.episods
                        }.first
                        
                        if eps == nil {
                            eps = SubsPleaseEpisods()
                            newEp = true
                        }
                        
                        try! realm.write {
                            eps!.episods = strParser.strEpisodNumber(curent.episods)
                            eps!.pubDate = curent.pubDate
                            obj!.titleName = curent.title
                            if newEp {
                                obj!.episods.append(eps!)
                            }
                            realm.add(eps!)
                            realm.add(obj!)
                        }
                        self.connectSPToAnime(obj!, eps!)
                    }
                }
            }
        }
    }
    
    func connectERToAnime (_ er: EraiRaws, _ episod: EraiRawsEpisods) {
        let realm = try! Realm()
        let anime = realm.objects(Anime.self)
        var curentAnime: Anime?
        anime.forEach {
            if $0.titleName.lowercased() == er.titleName.lowercased() || $0.ERName == er.titleName{
                curentAnime = $0
            }
        }
        if curentAnime != nil {
            try! realm.write {
                er.connect = true
                let curEpisod = curentAnime?.episod.where {
                    $0.episods == episod.episods
                }.first
                curEpisod?.ERE = episod
                curentAnime?.ERName = er.titleName
                realm.add(er)
                if curEpisod != nil {
                    realm.add(curEpisod!)
                }
                realm.add(curentAnime!)
            }
        }
    }
    
    func connectSPToAnime (_ sp: SubsPlease, _ episod: SubsPleaseEpisods) {
        let realm = try! Realm()
        let anime = realm.objects(Anime.self)
        var curentAnime: Anime?
        anime.forEach {
            if $0.titleName.lowercased() == sp.titleName.lowercased() || $0.ERName == sp.titleName{
                curentAnime = $0
            }
        }
        if curentAnime != nil {
            try! realm.write {
                sp.connect = true
                let curEpisod = curentAnime?.episod.where {
                    $0.episods == episod.episods
                }.first
                curEpisod?.SPE = episod
                curentAnime!.SPName = sp.titleName
                realm.add(sp)
                if curEpisod != nil {
                    realm.add(curEpisod!)
                }
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
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let anime = realm.objects(Anime.self)
        let curentAnime = anime.where{
            $0.id == id
        }.first
        let episods = curentAnime?.episod
        episods?.forEach {
            
            var eraiRawsEpisodInfo: EraiRawsEpisodInfo
            var subsPleaseEpisodInfo: SubsPleaseEpisodInfo
            if $0.ERE == nil {
                eraiRawsEpisodInfo = EraiRawsEpisodInfo(pubDate: nil, status: "Non", Episod: "", subtitles: "")
            }
            else {
                eraiRawsEpisodInfo = EraiRawsEpisodInfo(pubDate: $0.ERE!.pubDate, status: "Good", Episod: $0.ERE!.episods, subtitles: $0.ERE!.subtitles)
            }
            if $0.SPE == nil {
                subsPleaseEpisodInfo = SubsPleaseEpisodInfo(pubDate: nil, episod: "", status: "Non")
            }
            else {
                subsPleaseEpisodInfo = SubsPleaseEpisodInfo(pubDate: $0.SPE!.pubDate, episod: $0.SPE!.episods, status: "Good")
            }
            
            let episodInfo = EpisodInfo(episod: $0.episods, pubdate: $0.pubDate)
            info.append(Info(episod: episodInfo, eraiRaws: eraiRawsEpisodInfo, subsPlease: subsPleaseEpisodInfo))
        }
        return info
    }
    
    func addConnection (animeID: Int, titleID: Int, type: String) {
        let realm = try! Realm()
        let anime = realm.objects(Anime.self)
        let curentAnime = anime.where {
            $0.id == animeID
        }.first
        if type == "EraiRaws"{
            if curentAnime!.ERName != nil {
                try! realm.write {
                    let eraiRaws = realm.objects(EraiRaws.self).where {
                        $0.titleName == (curentAnime?.ERName)!
                    }.first
                    let episod = curentAnime?.episod
                    episod?.forEach {
                        $0.ERE = nil
                        realm.add($0)
                    }
                    eraiRaws!.connect = nil
                    curentAnime!.ERName = eraiRaws!.titleName
                    realm.add(eraiRaws!)
                    realm.add(curentAnime!)
                }
            }
            let eraiRaws = realm.objects(EraiRaws.self)
            let curentEraiRaws = eraiRaws.where {
                $0.id == titleID
            }.first
            
            try! realm.write {
                curentAnime!.ERName = curentEraiRaws!.titleName
                curentEraiRaws!.connect = true
                realm.add(curentEraiRaws!)
                realm.add(curentAnime!)
            }
        }
        else {
            if curentAnime!.SPName != nil {
                try! realm.write {
                    let subsPlease = realm.objects(SubsPlease.self).where {
                        $0.titleName == (curentAnime?.SPName)!
                    }.first
                    let episod = curentAnime?.episod
                    episod?.forEach {
                        $0.SPE = nil
                        realm.add($0)
                    }
                    subsPlease!.connect = nil
                    curentAnime!.SPName = subsPlease!.titleName
                    realm.add(subsPlease!)
                    realm.add(curentAnime!)
                }
            }
            let subsPlease = realm.objects(SubsPlease.self)
            let curentSubsPlease = subsPlease.where {
                $0.id == titleID
            }.first
            
            try! realm.write {
                curentAnime!.SPName = curentSubsPlease!.titleName
                curentSubsPlease!.connect = true
                realm.add(curentSubsPlease!)
                realm.add(curentAnime!)
            }
        }
        refreshEpisods(animeID: animeID, titleID: titleID, type: type)
    }
    
    func refreshEpisods (animeID: Int, titleID: Int, type: String) {
        let realm = try! Realm()
        let anime = realm.objects(Anime.self).where {
            $0.id == animeID
        }.first
        let episods = anime?.episod
        if type == "EraiRaws" {
            let eraiRawsEpisods = realm.objects(EraiRaws.self).where {
                $0.titleName == anime!.ERName ?? ""
            }.first!.episods
            episods?.forEach { episod in
                eraiRawsEpisods.forEach { er in
                    if episod.episods == er.episods {
                        try! realm.write {
                            episod.ERE = er
                            realm.add(episod)
                        }
                    }
                }
            }
        }
        else {
            let subsPleaseEpisods = realm.objects(SubsPlease.self).where {
                $0.titleName == anime?.SPName ?? ""
            }.first!.episods
            episods?.forEach { episod in
                subsPleaseEpisods.forEach { er in
                    if episod.episods == er.episods {
                        try! realm.write {
                            episod.SPE = er
                            realm.add(episod)
                        }
                    }
                }
            }
        }
        
    }
}
