//
//  DictionaryViewController.swift
//  AideA_master
//
//  Created by AppCircle on 2017/10/26.
//  Copyright © 2017年 NichibiAppCircle. All rights reserved.
//

import UIKit
import RealmSwift

class DictionaryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var alphabetsCollectionView: UICollectionView!
    
    var tests = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "o", "p", "q", "r", "s", "t", "u", "v", "w", "z", "?", "*"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nibAlphabet = UINib(nibName: "AlphabetCell", bundle: nil)
        self.alphabetsCollectionView.register(nibAlphabet, forCellWithReuseIdentifier: "alphabetCell")
        
        self.alphabetsCollectionView.backgroundColor = UIColor.clear
        
        
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
        return self.tests.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alphabetCell", for: indexPath) as! AlphabetCell
        
        cell.lblAlphabet.text = self.tests[indexPath.row]
        
        return cell
    }
    
    
}
