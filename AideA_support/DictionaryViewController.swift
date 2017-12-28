//
//  DictionaryViewController.swift
//  AideA_master
//
//  Created by AppCircle on 2017/10/26.
//  Copyright © 2017年 NichibiAppCircle. All rights reserved.
//

import UIKit
import RealmSwift

class DictionaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var combinedLabel: UILabel!
    @IBOutlet weak var alphabetsCollectionView: UICollectionView!
    @IBOutlet weak var wordTableView: UITableView!
    
    let operationAlphabets = OperationAlphabets()
    var combinAlphabets: String = ""
    
    var wordItem: Results<DictionaryModel>!
    var realm: Realm!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nibWord = UINib(nibName: "WordCell", bundle: nil)
        self.wordTableView.register(nibWord, forCellReuseIdentifier: "wordCell")
        let nibAlphabet = UINib(nibName: "AlphabetCell", bundle: nil)
        self.alphabetsCollectionView.register(nibAlphabet, forCellWithReuseIdentifier: "alphabetCell")
        
        self.wordTableView.backgroundColor = UIColor.clear
        self.alphabetsCollectionView.backgroundColor = UIColor.clear
        
        self.combinedLabel.text = self.combinAlphabets
        self.loadSeedRealm()
    }
    
    func loadSeedRealm()
    {
        let config = Realm.Configuration(fileURL: Bundle.main.url(forResource: "DictionaryDB",withExtension: "realm"),readOnly: true)
        self.realm = try! Realm(configuration: config)
        self.wordItem = self.selectAllRealm()
    }
    
    func selectAllRealm() -> Results<DictionaryModel>
    {
        return self.realm.objects(DictionaryModel.self)
    }
    
    func selectFilterRealm(column: String, condition: String) -> Results<DictionaryModel>
    {
        return self.realm.objects(DictionaryModel.self).filter(column + " LIKE '" + condition + "'")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.wordItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordCell
        let object = self.wordItem[indexPath.row]
        cell.lblWord.text = object.word
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let object = self.wordItem[indexPath.row]
        print("word: \(object.word)")
        print("meaning: \(object.meaning)")
        self.showWordMeaning(word: object.word, meaning: object.meaning)
        self.wordTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showWordMeaning(word: String, meaning: String)
    {
        let alert = UIAlertController(title: word,
                                      message: "意味：" + meaning,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let closingAction = UIAlertAction(title: "閉じる",
                                          style: UIAlertActionStyle.cancel,
                                          handler: nil)
        
        alert.addAction(closingAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.operationAlphabets.returnWithWildcardAlphabets().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alphabetCell", for: indexPath) as! AlphabetCell
        
        cell.lblAlphabet.text = self.operationAlphabets.returnWithWildcardAlphabets()[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.combinAlphabets += self.operationAlphabets.returnWithWildcardAlphabets()[indexPath.row]
        self.combinedLabel.text = self.combinAlphabets
        self.wordItem = self.selectFilterRealm(column: "word", condition: self.combinAlphabets)
        self.wordTableView.reloadData()
    }
    
    @IBAction func clearAction(_ sender: Any)
    {
        if (self.combinAlphabets.count == 0)
        {
            return
        }
        self.combinAlphabets = String(self.combinAlphabets[..<self.combinAlphabets.index(before: self.combinAlphabets.endIndex)])
        self.combinedLabel.text = self.combinAlphabets
        if (self.combinAlphabets.count == 0)
        {
            self.wordItem = self.selectAllRealm()
            self.wordTableView.reloadData()
            return
        }
        self.wordItem = self.selectFilterRealm(column: "word", condition: self.combinAlphabets)
        self.wordTableView.reloadData()
    }
    
}
