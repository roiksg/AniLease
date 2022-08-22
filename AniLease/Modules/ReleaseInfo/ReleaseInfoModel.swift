//
//  ReleaseInfoModel.swift
//  AniLease
//
//  Created by VironIT on 19.08.22.
//

import Foundation

class ReleaseInfoModel {
    
    weak var controller: ReleaseInfoController!
    
    init (_ vc: ReleaseInfoController) {
        controller = vc
    }
    func network() -> String {
        var contents: String = ""
    
        Network.makeAnimeImage()
//        if let url = URL(string: "https://www.google.com") {
//            do {
//                contents = try String(contentsOf: url)
//                print(contents)
//            } catch {
//                // contents could not be loaded
//            }
//        } else {
//            // the URL was bad!
//        }
        return contents
    }
}
