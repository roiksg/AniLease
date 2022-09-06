//
//  ViewController.swift
//  AniLease
//
//  Created by VironIT on 17.08.22.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController {
    @IBOutlet weak var collectionRelease: UICollectionView!
    
    @IBOutlet private weak var hiddenButton: UIButton!
    
    @IBOutlet private weak var searchTextField: UITextField!
    
    private var viewModel: MainViewModel!
    
    private var cellIdentifiers: Int!
    
    private var hidden: Bool!
    
    private var favorite: Bool!
    
    private var search: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        hidden = false
        favorite = false
        self.viewModel = MainViewModel(self)
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:) ), for: .allEditingEvents)
        searchTextField.autocorrectionType = .no
        self.collectionRelease.dataSource = self
        self.collectionRelease.delegate = self
        self.collectionRelease.register(.init(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifiers)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if favorite == false {
            viewModel.loadItemCell(fav: false, hid: hidden, search: search)
        }
        else {
            viewModel.loadItemCell(fav: true, hid: nil, search: search)
        }
        if favorite == true {
            hiddenButton.isHidden = true
        }
        else {
            hiddenButton.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ReleaseInfoController {
            if let vc = segue.destination as? ReleaseInfoController {
                vc.identifier = cellIdentifiers
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        search = searchTextField.text?.lowercased() ?? ""
        if favorite == true {
            viewModel.loadItemCell(fav: true, hid: hidden, search: search)
        }
        else {
            viewModel.loadItemCell(fav: false, hid: hidden, search: search)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func unwindMain(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func tapHidden(_ sender: Any) {
        if hidden == false {
            hidden = true
            hiddenButton.setImage(UIImage(systemName: "eye"), for: .normal)
            if favorite == false {
                viewModel.loadItemCell(fav: false, hid: hidden, search: search)
            }
            self.view.makeToast("show hidden anime")
        }
        else {
            hidden = false
            hiddenButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            if favorite == false {
                viewModel.loadItemCell(fav: false, hid: hidden, search: search)
            }
            self.view.makeToast("remove hidden anime")
        }
    }
    
    @IBAction func tapAll(_ sender: Any) {
        favorite = false
        viewModel.loadItemCell(fav: false, hid: hidden, search: search)
        hiddenButton.isHidden = false
    }
    
    @IBAction func tapFavorite(_ sender: Any) {
        favorite = true
        viewModel.loadItemCell(fav: true, hid: nil, search: search)
        hiddenButton.isHidden = true
    }
    
}

// MARK: extension

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.releaseCount()
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

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension ViewController: UITextFieldDelegate {
    // hidde keyboard for tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}

