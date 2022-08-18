//
//  ViewController.swift
//  AniLease
//
//  Created by VironIT on 17.08.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionRelease: UICollectionView!
    
    private var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(self)
        collectionRelease.dataSource = self
        collectionRelease.delegate = self
        collectionRelease.register(.init(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifair)
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.releaseCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifair, for: indexPath) as! MainCollectionViewCell
        collectionCell.configureXib(viewModel.returnCellModel()[indexPath.row])
        return collectionCell
    }
}

extension ViewController: UICollectionViewDelegate {}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 170)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}

