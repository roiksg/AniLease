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
    
    func loadModel(_ search: String = "") {
        eraiRawsCell = []
        subsPleaseCell = []
        EREpisodModel(search)
        SPEpisodModel(search)
        controller.modelUpdate(er: eraiRawsCell, sp: subsPleaseCell)
    }
    
    func EREpisodModel(_ search: String) {
        
        let ER = realm.objects(EraiRaws.self)
        
        var name = search
        name = name.lowercased()
        
        let eraiRaws = ER.where {
            $0.connect != true
        }
        
        eraiRaws.forEach {
            if name == ""{
                eraiRawsCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: $0.episods.last!.episods, date: $0.episods.last!.pubDate))
            }
            else if $0.titleName.lowercased().contains(name) {
                eraiRawsCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: $0.episods.last!.episods, date: $0.episods.last!.pubDate))
            }
        }
    }
    
    func SPEpisodModel(_ search: String) {
        
        let SP = realm.objects(SubsPlease.self)
        
        var name = search
        name = name.lowercased()
        
        let subsPlease = SP.where {
            $0.connect != true
        }
        
        subsPlease.forEach {
            if name == ""{
                subsPleaseCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: $0.episods.last!.episods, date: $0.episods.last!.pubDate))
            }
            else if $0.titleName.lowercased().contains(name) {
                subsPleaseCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: $0.episods.last!.episods, date: $0.episods.last!.pubDate))
            }
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
