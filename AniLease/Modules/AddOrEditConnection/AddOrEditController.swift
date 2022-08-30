//
//  AddOrEditController.swift
//  AniLease
//
//  Created by VironIT on 30.08.22.
//

import UIKit

class AddOrEditController: UIViewController {
    
    @IBOutlet weak var collectionEpisod: UICollectionView!
    @IBOutlet weak var eraiRawsView: UIView!
    @IBOutlet weak var subsPleaseView: UIView!
    private var viewModel: AddOrEditModel!
    private var eraiRawsCell: [Cell] = []
    private var subsPleaseCell: [Cell] = []
    private var collectionCellModel: [Cell] = []
    private var type: String!
    
    var identifier: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddOrEditModel(self)
        self.collectionEpisod.dataSource = self
        self.collectionEpisod.delegate = self
        self.collectionEpisod.register(.init(nibName: "EpisodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: EpisodCollectionViewCell.identifier)
        type = "EraiRaws"
        collectionCellModel = eraiRawsCell
        // Do any additional setup after loading the view.
    }
    
    func modelUpdate(er: [Cell], sp: [Cell]) {
        eraiRawsCell = er
        subsPleaseCell = sp
    }
    @IBAction func eraiRawsTap(_ sender: Any) {
        collectionCellModel = eraiRawsCell
        type = "EraiRaws"
        eraiRawsView.backgroundColor = .darkGray
        subsPleaseView.backgroundColor = .lightGray
        collectionEpisod.reloadData()
    }
    @IBAction func subsPleaseTap(_ sender: Any) {
        collectionCellModel = subsPleaseCell
        type = "SubsPlease"
        eraiRawsView.backgroundColor = .lightGray
        subsPleaseView.backgroundColor = .darkGray
        collectionEpisod.reloadData()
    }
    

}

extension AddOrEditController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCellModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodCollectionViewCell.identifier, for: indexPath) as! EpisodCollectionViewCell
        collectionCell.configureXib(type, collectionCellModel[indexPath.row].title, collectionCellModel[indexPath.row].lastepisod, collectionCellModel[indexPath.row].date)
        return collectionCell
    }
}

extension AddOrEditController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 400, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
