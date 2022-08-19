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
    
    private var cellIdentifiers: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(self)
        collectionRelease.dataSource = self
        collectionRelease.delegate = self
        collectionRelease.register(.init(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifiers)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ReleaseInfoController {
            if let vc = segue.destination as? ReleaseInfoController {
                vc.identifier = cellIdentifiers
            }
        }
    }
    
    @IBAction func unwindMain(_ unwindSegue: UIStoryboardSegue) {
        
    }
}

// MARK: extension

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.releaseCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifiers, for: indexPath) as! MainCollectionViewCell
        collectionCell.configureXib(viewModel.returnCellModel()[indexPath.row])
        collectionCell.segue = { [unowned self] in
            self.cellIdentifiers = self.viewModel.returnCellModel()[indexPath.row].ID
            self.performSegue(withIdentifier: "ReleaseInfoVCsegue", sender: self)
        }
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

