//
//  AddOrEditController.swift
//  AniLease
//
//  Created by VironIT on 30.08.22.
//

import UIKit

class AddOrEditController: UIViewController {
    
    // MARK:  IBOutlet
    
    @IBOutlet private weak var collectionEpisod: UICollectionView!
    @IBOutlet private weak var eraiRawsView: UIView!
    @IBOutlet private weak var subsPleaseView: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    private var viewModel: AddOrEditModel!
    private var eraiRawsCell: [Cell] = []
    private var subsPleaseCell: [Cell] = []
    private var collectionCellModel: [Cell] = []
    private var type: String!
    
    var identifier: Int!
    
    // MARK:  OVERRIDE

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddOrEditModel(self)
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:) ), for: .allEditingEvents)
        searchTextField.autocorrectionType = .no
        self.collectionEpisod.dataSource = self
        self.collectionEpisod.delegate = self
        self.collectionEpisod.register(.init(nibName: "EpisodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: EpisodCollectionViewCell.identifier)
        type = "EraiRaws"
        collectionCellModel = eraiRawsCell
        sortCollection()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadModel()
        collectionEpisod.reloadData()
    }
    
    // MARK:  FUNC
    
    func modelUpdate(er: [Cell], sp: [Cell]) {
        eraiRawsCell = er
        subsPleaseCell = sp
    }
    
    func sortCollection() {
        collectionCellModel = collectionCellModel.sorted {
            $0.date > $1.date
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func reloadCollection() {
        if type == "EraiRaws" {
            collectionCellModel = eraiRawsCell
        }
        else {
            collectionCellModel = subsPleaseCell
        }
        collectionEpisod.reloadData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let search = searchTextField.text ?? ""
        viewModel.loadModel(search)
        reloadCollection()
    }
    
    // MARK:  IBAction
    
    @IBAction func eraiRawsTap(_ sender: Any) {
        collectionCellModel = eraiRawsCell
        sortCollection()
        type = "EraiRaws"
        eraiRawsView.backgroundColor = .darkGray
        subsPleaseView.backgroundColor = .lightGray
        collectionEpisod.reloadData()
    }
    @IBAction func subsPleaseTap(_ sender: Any) {
        collectionCellModel = subsPleaseCell
        sortCollection()
        type = "SubsPlease"
        eraiRawsView.backgroundColor = .lightGray
        subsPleaseView.backgroundColor = .darkGray
        collectionEpisod.reloadData()
    }
    

}

// MARK:  EXTENSION



// MARK:  UICollectionViewDataSource

extension AddOrEditController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCellModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodCollectionViewCell.identifier, for: indexPath) as! EpisodCollectionViewCell
        collectionCell.configureXib(type, collectionCellModel[indexPath.row].title, collectionCellModel[indexPath.row].lastepisod, collectionCellModel[indexPath.row].date)
        collectionCell.closure = { [unowned self] in
            let connection = viewModel.getContactInfo(id: identifier, type: type)
            let alert: UIAlertController
            if connection == "" {
                alert = .init(title: "confirmation", message: "??ou are sure that you go to bind this release", preferredStyle: .alert)
                let yesAlertAction = UIAlertAction(title: "Yes", style: .default) { [unowned self] _ in
                    let dataBase = DataBase()
                    dataBase.addConnection(animeID: identifier, titleID: collectionCellModel[indexPath.row].id, type: type)
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
                let noAlertAction = UIAlertAction(title: "No", style: .default)
                alert.addAction(yesAlertAction)
                alert.addAction(noAlertAction)
                self.present(alert, animated: true)
            }
            else if connection != collectionCellModel[indexPath.row].title {
                alert = .init(title: "confirmation", message: "You are sure that you go will change the binding of this release", preferredStyle: .alert)
                let yesAlertAction = UIAlertAction(title: "Yes", style: .default) { [unowned self] _ in
                    let dataBase = DataBase()
                    dataBase.addConnection(animeID: identifier, titleID: collectionCellModel[indexPath.row].id, type: type)
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
                let noAlertAction = UIAlertAction(title: "No", style: .default)
                alert.addAction(yesAlertAction)
                alert.addAction(noAlertAction)
                self.present(alert, animated: true)
            }
            
        }
        return collectionCell
    }
}

// MARK:  UICollectionViewDelegateFlowLayout

extension AddOrEditController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK:  UITextFieldDelegate

extension AddOrEditController: UITextFieldDelegate {
    // hidde keyboard for tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}
