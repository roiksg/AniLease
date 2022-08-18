//
//  ViewModel.swift
//  AniLease
//
//  Created by VironIT on 17.08.22.
//

import Foundation
import CoreVideo

class MainViewModel {
    weak var controller: ViewController?
    
    private var release: [ReleaseMainModel] = []
    
    init (_ vc: ViewController) {
        controller = vc
        let element1 = ReleaseMainModel(name: "test1", JpEnName: "test1", image: "testitem", time: 572748, Episod: "EP 4/12", ID: "123")
        let element2 = ReleaseMainModel(name: "test1", JpEnName: "test1", image: "testitem", time: 572748, Episod: "EP 4/12", ID: "123")
        self.release.append(element1)
        self.release.append(element2)
    }
    
    func releaseCount() -> Int{
        release.count
    }
    
    func returnCellModel() -> [ReleaseMainModel] {
        release
    }
}
