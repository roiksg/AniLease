//
//  ReleaseInfoController.swift
//  AniLease
//
//  Created by VironIT on 19.08.22.
//

import UIKit
import Kingfisher

class ReleaseInfoController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var episodCollection: UICollectionView!
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
//        self.episodCollection.dataSource = self
//        self.episodCollection.delegate = self
        self.episodCollection.register(.init(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReleaseInfoCollectionCell.identifier)
        // Do any additional setup after loading the view.
    }
    
}

//extension ViewController: UICollectionViewDelegate {}
//
//extension ReleaseInfoController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.releaseCount()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifiers, for: indexPath) as! MainCollectionViewCell
//        collectionCell.configureXib(viewModel.returnCellModel()[indexPath.row])
//        collectionCell.segue = { [unowned self] in
//            self.cellIdentifiers = self.viewModel.returnCellModel()[indexPath.row].ID
//            self.performSegue(withIdentifier: "ReleaseInfoVCsegue", sender: self)
//        }
//
//        return collectionCell
//    }
//}
