//
//  ReleaseInfoController.swift
//  AniLease
//
//  Created by VironIT on 19.08.22.
//

import UIKit
import Kingfisher

class ReleaseInfoController: UIViewController {
    
    @IBOutlet weak var lastEpisod: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name: UILabel!
    private var viewModel: ReleaseInfoModel?
    
    @IBOutlet weak var descriptionText: UITextView!
    var identifier: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReleaseInfoModel(self)
        // Do any additional setup after loading the view.
    }
    
}
