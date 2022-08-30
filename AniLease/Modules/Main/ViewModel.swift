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
    
    func loadItemCell(){
        for item in self.item {
            let element = ReleaseMainModel(name: item.titleName, image: item.image, time: 0, Episod: item.episod.last?.episods ?? "EP NONE", ID: item.id)
            self.release.append(element)
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
            self.loadItemCell()
            self.controller.collectionRelease.reloadData()
        }
        dataBase.updateAnime(closure)
    }
}
