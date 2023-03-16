//
//  ZooListCollectionViewCell.swift
//  ZooApp
//
//  Created by Minaya Yagubova on 10.03.23.
//

import UIKit

class ZooListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var zooName: UILabel!
    @IBOutlet weak var zooInfo: UILabel!
    @IBOutlet weak var zooRating: UILabel!
 
    var aboutZooCallBack: ((Int)->())?
    
    @IBAction func aboutZoo(_ sender: Any) {
        aboutZooCallBack?(tag)
    }
    
    @IBAction func addToFav(_ sender: Any) {
        
    }
    
}
