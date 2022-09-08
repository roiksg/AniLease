//
//  AddOrEditModel.swift
//  AniLease
//
//  Created by VironIT on 30.08.22.
//

import Foundation
import RealmSwift


class AddOrEditModel {
    
    // MARK:  VAR
    
    weak var controller: AddOrEditController!
    private var realm: Realm!
    private var eraiRawsCell: [Cell] = []
    private var subsPleaseCell: [Cell] = []
    
    // MARK:  INIT
    
    init (_ vc: AddOrEditController) {
        controller  = vc
        realm = try! Realm()
        loadModel()
    }
    
    // MARK:  FUNC
    
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
            //
            var eps: [String] = []
            $0.episods.forEach {
                eps.append($0.episods)
            }
            eps = eps.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
            if name == ""{
                eraiRawsCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: eps.last!, date: $0.episods.last!.pubDate))
            }
            else if $0.titleName.lowercased().contains(name) {
                eraiRawsCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: eps.last!, date: $0.episods.last!.pubDate))
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
            var eps: [String] = []
            $0.episods.forEach {
                eps.append($0.episods)
            }
            eps = eps.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
            if name == ""{
                subsPleaseCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: eps.last!, date: $0.episods.last!.pubDate))
            }
            else if $0.titleName.lowercased().contains(name) {
                subsPleaseCell.append(Cell(id: $0.id, title: $0.titleName, lastepisod: eps.last!, date: $0.episods.last!.pubDate))
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
