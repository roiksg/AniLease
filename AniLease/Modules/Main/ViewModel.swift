//
//  ViewModel.swift
//  AniLease
//
//  Created by VironIT on 17.08.22.
//

import Foundation
import RealmSwift

class MainViewModel {
    weak var controller: ViewController!
    
    private var release: [ReleaseMainModel] = []
    private var dataBase = DataBase()
    private var item: [Anime] = []
    private let realm = try! Realm()
    private var urlString = "https://www.livechart.me/feeds/episodes"
    
    init (_ vc: ViewController) {
        controller = vc
        parserLiveChartRSS()
    }
    
    func loadItemCell(fav: Bool? = nil, hid: Bool? = nil, search: String){
        release = []
        item = item.sorted { $0.pubDate > $1.pubDate }
        for item in self.item {
            let element = ReleaseMainModel(name: item.titleName, image: item.image, time: 0, Episod: item.episod.last?.episods ?? "EP NONE", ID: item.id, favorite: item.favorite, hidden: item.hidden, lastER: item.episod.last?.ERE?.episods ?? "", lastSP: item.episod.last?.SPE?.episods ?? "")
            if fav == false && hid == false && element.hidden == false {
                searchFunction(element, search)
            }
            
            else if fav == false && hid == true && (element.hidden == true || element.hidden == false){
                searchFunction(element, search)
            }
            else if fav == true && element.favorite == true {
                searchFunction(element, search)
            }
        }
        controller.collectionRelease.reloadData()
    }
    
    func searchFunction(_ element: ReleaseMainModel, _ search: String) {
        if search == "" {
            release.append(element)
        }
        else if element.name.lowercased().contains(search) {
            release.append(element)
        }
    }
    
    func releaseCount() -> Int{
        release.count
    }
    
    func returnCellModel() -> [ReleaseMainModel] {
        release
    }
    
    func parserLiveChartRSS() {
        let closure = { [unowned self] in
            let anime = self.realm.objects(Anime.self)
            for an in anime {
                self.item.append(an)
            }
            self.loadItemCell(fav: false, hid: false, search: "")
        }
        dataBase.updateAnime(closure)
    }
}
