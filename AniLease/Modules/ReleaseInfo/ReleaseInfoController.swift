//
//  ReleaseInfoController.swift
//  AniLease
//
//  Created by VironIT on 19.08.22.
//

import UIKit

class ReleaseInfoController: UIViewController {
    
    private var viewModel: ReleaseInfoModel?
    
    var identifier: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReleaseInfoModel(self)
        // Do any additional setup after loading the view.
    }

}
