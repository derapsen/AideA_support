//
//  QRViewController.swift
//  AideA_master
//
//  Created by AppCircle on 2017/10/26.
//  Copyright © 2017年 NichibiAppCircle. All rights reserved.
//

import UIKit

class QRViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var qrcodeImage: UIImageView!
    @IBOutlet weak var alphabetLabel: UILabel!
    @IBOutlet weak var alphabetsCollectionView: UICollectionView!
    
    let operationAlphabets = OperationAlphabets()
    var selectAlphabet = "a"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nibAlphabet = UINib(nibName: "AlphabetCell", bundle: nil)
        self.alphabetsCollectionView.register(nibAlphabet, forCellWithReuseIdentifier: "alphabetCell")
        
        self.alphabetsCollectionView.backgroundColor = UIColor.clear
        
        self.showQRCode(select: self.selectAlphabet)
    }
    
    func showQRCode(select: String)
    {
        let str = "AideA:" + ":master:" + select
        self.qrcodeImage.image = QRCode.generateQRCode(str)
        self.alphabetLabel.text = select
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.operationAlphabets.alphabets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alphabetCell", for: indexPath) as! AlphabetCell
        
        cell.lblAlphabet.text = self.operationAlphabets.alphabets[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.showQRCode(select: self.operationAlphabets.alphabets[indexPath.row])
    }
}

