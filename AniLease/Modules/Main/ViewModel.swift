//
//  ViewModel.swift
//  AniLease
//
//  Created by VironIT on 17.08.22.
//

import Foundation
import RealmSwift

class MainViewModel {
    
    // MARK:  var / let
    
    weak var controller: ViewController!
    
    private var release: [ReleaseMainModel] = []
    private var dataBase = DataBase()
    private var item: [Anime] = []
    private let realm = try! Realm()
    private var urlString = "https://www.livechart.me/feeds/episodes"
    
    // MARK:  INIT
    
    init (_ vc: ViewController,_ hidden: Bool) {
        controller = vc
        parserLiveChartRSS(hidden)
    }
    
    // MARK:  FUNC
    
    func loadItemCell(fav: Bool? = nil, hid: Bool? = nil, search: String){
        release = []
        item = item.sorted { $0.pubDate > $1.pubDate }
        for item in self.item {
            let element = ReleaseMainModel(name: item.titleName, image: item.image, Episod: item.episod.last?.episods ?? "EP NONE", ID: item.id, favorite: item.favorite, hidden: item.hidden, lastER: item.episod.last?.ERE?.episods ?? "", lastSP: item.episod.last?.SPE?.episods ?? "")
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
    
    func parserLiveChartRSS(_ hidden: Bool) {
        let closure = { [unowned self] in
            let anime = self.realm.objects(Anime.self)
            for an in anime {
                self.item.append(an)
            }
            self.loadItemCell(fav: false, hid: false, search: "")
        }
        let update = { [unowned self] in
            self.loadItemCell(fav: false, hid: hidden, search: "")
            self.controller.collectionRelease.reloadData()
        }
        dataBase.updateAnime(closure, update)
    }
}
