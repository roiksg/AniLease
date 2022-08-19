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
}
