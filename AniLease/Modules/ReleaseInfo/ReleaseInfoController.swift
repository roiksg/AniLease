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
    private var viewModel: ReleaseInfoModel!
    
    var identifier: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReleaseInfoModel(self)
        self.episodCollection.dataSource = self
        self.episodCollection.delegate = self
        self.episodCollection.register(.init(nibName: "ReleaseInfoCollectionCell", bundle: nil), forCellWithReuseIdentifier: ReleaseInfoCollectionCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        episodCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddOrEditController {
            if let vc = segue.destination as? AddOrEditController {
                vc.identifier = identifier
            }
        }
    }
    
    @IBAction func showAddOrEdit(_ sender: Any) {
        self.performSegue(withIdentifier: "AddOrEditSegue", sender: self)
    }
    
    @IBAction func unwindReleaseInfo(_ unwindSegue: UIStoryboardSegue) {
        
    }
}

extension ReleaseInfoController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.releaseCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReleaseInfoCollectionCell.identifier, for: indexPath) as! ReleaseInfoCollectionCell
        collectionCell.configureXib(viewModel.returnCellModel()[indexPath.row])
        return collectionCell
    }
}

extension ReleaseInfoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
