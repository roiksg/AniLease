//
//  AddOrEditModel.swift
//  AniLease
//
//  Created by VironIT on 30.08.22.
//

import Foundation
import RealmSwift


class AddOrEditModel {
    
    weak var controller: AddOrEditController!
    private var realm: Realm!
    private var eraiRawsCell: [Cell] = []
    private var subsPleaseCell: [Cell] = []
    
    init (_ vc: AddOrEditController) {
        controller  = vc
        realm = try! Realm()
        loadModel()
    }
    
    func loadModel() {
        EREpisodModel()
        SPEpisodModel()
        controller.modelUpdate(er: eraiRawsCell, sp: subsPleaseCell)
    }
    
    func EREpisodModel() {
        let ER = realm.objects(EraiRaws.self)
        let eraiRaws = ER.where {
            $0.connect != true
        }
        eraiRaws.forEach {
            eraiRawsCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: $0.episods.last!.episods, date: $0.episods.last!.pubDate))
        }
    }
    
    func SPEpisodModel() {
        let SP = realm.objects(SubsPlease.self)
        let subsPlease = SP.where {
            $0.connect != true
        }
        subsPlease.forEach {
            subsPleaseCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: $0.episods.last!.episods, date: $0.episods.last!.pubDate))
        }
    }
    
    func getContactInfo(id: Int, type: String) ->  String {
        let anime = realm.objects(Anime.self)
        let curentAnume = anime.where {
            $0.id == id
        }.first
        if type == "EraiRaws" {
            return curentAnume!.ERName ?? ""
        }
        else {
            return curentAnume!.SPName ?? ""
        }
    }
}
