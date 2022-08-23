//
//  ViewModel.swift
//  AniLease
//
//  Created by VironIT on 17.08.22.
//

import Foundation
import CoreVideo

class MainViewModel {
    weak var controller: ViewController!
    
    private var release: [ReleaseMainModel] = []
    private var item: [LiveChartRSS] = []
    private var parser = LiveChartParserXML()
    private var urlString = "https://www.livechart.me/feeds/episodes"
    
    init (_ vc: ViewController) {
        controller = vc
        self.parserLiveChartRSS()
    }
    
    func loadItemCell(){
        for item in self.item {
            let element = ReleaseMainModel(name: item.title, JpEnName: item.link, image: item.imageURL, time: 0, Episod: "EP NONE", ID: "123")
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
        guard let url = URL(string: urlString) else {return}
        parser.getLiveChartItem(url) { (item) in
            self.item = item
            
            self.loadItemCell()
            DispatchQueue.main.async {
                self.controller.collectionRelease.reloadData()
            }
        }
    }
}
