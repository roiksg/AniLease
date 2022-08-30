//
//  ReleaseInfoModel.swift
//  AniLease
//
//  Created by VironIT on 19.08.22.
//

import Foundation
import RealmSwift

class ReleaseInfoModel {
    
    private var id: Int!
    private var dataBase = DataBase()
    private var realm = try! Realm()
    private var animeEpisods: [AnimeEpisods]!
    private var info: [Info]!
    
    weak var controller: ReleaseInfoController!
    
    init (_ vc: ReleaseInfoController) {
        controller = vc
        id = vc.identifier
        animeEpisods = dataBase.getEpisod(id)
        loadDate()
    }
    
    func loadDate() {
        let anime = realm.objects(Anime.self)
        let curentAnime = anime.where {
            $0.id == id
        }.first!
        let url = URL(string: curentAnime.image)
        controller.image.kf.setImage(with: url)
        controller.name.text = curentAnime.titleName
        controller.category.text = curentAnime.category
        controller.lastEpisod.text = curentAnime.episod.last?.episods
        info  = dataBase.getInfoModel(id)
    }
    
    func releaseCount() -> Int{
        animeEpisods.count
    }

    func returnCellModel() -> [Info] {
        info
    }
}
