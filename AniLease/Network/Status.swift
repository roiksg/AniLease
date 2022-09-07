//
//  Status.swift
//  AniLease
//
//  Created by VironIT on 6.09.22.
//

import Foundation
import AVFoundation

class Status {
    
    static var shared: Status = {
            let instance = Status()
            return instance
        }()
    
    private init() {}
    
    var controller: ViewController?
    var description = ""
    var status: Int? {
        didSet {
            if status != 200 {
                controller?.changeStstus(status!, description)
            }
        }
        
    }
    
    func setVC (_ vc: ViewController) {
        controller = vc
    }
}

extension Status: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
