//
//  ReleaseInfoController.swift
//  AniLease
//
//  Created by VironIT on 19.08.22.
//

import UIKit
import Kingfisher
import Toast_Swift

class ReleaseInfoController: UIViewController, UICollectionViewDelegate {
    
    // MARK:  IBOutlet

    @IBOutlet weak var episodCollection: UICollectionView!
    @IBOutlet weak var lastEpisod: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var hidden: UIButton!
    private var viewModel: ReleaseInfoModel!
    private var anime: Anime!
    
    
    var identifier: Int!
    
    // MARK:  override

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReleaseInfoModel(self)
        self.episodCollection.dataSource = self
        self.episodCollection.delegate = self
        self.episodCollection.register(.init(nibName: "ReleaseInfoCollectionCell", bundle: nil), forCellWithReuseIdentifier: ReleaseInfoCollectionCell.identifier)
        anime = viewModel.getThisAnime()
        changeImage()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadDate()
        anime = viewModel.getThisAnime()
        episodCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddOrEditController {
            if let vc = segue.destination as? AddOrEditController {
                vc.identifier = identifier
            }
        }
    }
    
    // MARK:  FUNC
    
    func changeImage() {
        if anime.favorite == true {
            favorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else {
            favorite.setImage(UIImage(systemName: "star"), for: .normal)
        }
        if anime.hidden == true {
            hidden.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        else {
            hidden.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    // MARK:  IBAction
    
    @IBAction func showAddOrEdit(_ sender: Any) {
        self.performSegue(withIdentifier: "AddOrEditSegue", sender: self)
    }
    
    @IBAction func unwindReleaseInfo(_ unwindSegue: UIStoryboardSegue) {
        
    }
    @IBAction func tapFavorite(_ sender: Any) {
        if anime.favorite == false {
            viewModel.changeAnime(anime, true, anime.hidden)
            changeImage()
            self.view.makeToast("add this anime to favorite")
        }
        else {
            viewModel.changeAnime(anime, false, anime.hidden)
            changeImage()
            self.view.makeToast("remove this anime to favorite")
        }
    }
    @IBAction func tapHidden(_ sender: Any) {
        if anime.hidden == false {
            viewModel.changeAnime(anime, anime.favorite, true)
            changeImage()
            self.view.makeToast("hide this anime")
        }
        else {
            viewModel.changeAnime(anime, anime.favorite, false)
            changeImage()
            self.view.makeToast("show this anime")
        }
    }
}

// MARK:  EXTENSION



// MARK:  UICollectionViewDataSource

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

// MARK:  UICollectionViewDelegateFlowLayout

extension ReleaseInfoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
