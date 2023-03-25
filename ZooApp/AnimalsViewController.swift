//
//  AnimalsViewController.swift
//  ZooApp
//
//  Created by Minaya Yagubova on 16.03.23.
//

import UIKit
import SwiftUI

class AnimalsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCollectionViewCell", for: indexPath) as! AnimalCollectionViewCell
        cell.animalName.text = animalList[indexPath.item].animal
        cell.animalName.text = animalList[indexPath.item].image
        return cell
    }
    

    @IBOutlet weak var animalListCollection: UICollectionView!
    var animalList = [AnimalsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonFileRead()
    }
    
    func jsonFileRead() {
        if let jsonFile = Bundle.main.url(forResource: "animalList", withExtension: "json") {
            let data = (try? Data(contentsOf: jsonFile))!
            do {
                animalList = try JSONDecoder().decode([AnimalsList].self, from: data)
                animalListCollection.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            print((jsonFile))
        }
    }

}
