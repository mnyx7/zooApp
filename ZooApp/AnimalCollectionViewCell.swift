//
//  AnimalCollectionViewCell.swift
//  ZooApp
//
//  Created by Minaya Yagubova on 16.03.23.
//

import UIKit

class AnimalCollectionViewCell: UICollectionViewCell {
    var animalListCallBack: ((Int)->())?
    
    @IBAction func addToFav(_ sender: Any) {
    }
    
    @IBAction func aboutAnimal(_ sender: Any) {
      animalListCallBack?(tag)
    }
    
    
    @IBOutlet weak var animalImg: UIImageView!
    @IBOutlet weak var animalName: UILabel!
}
