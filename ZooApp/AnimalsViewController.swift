//
//  AnimalsViewController.swift
//  ZooApp
//
//  Created by Minaya Yagubova on 16.03.23.
//

import UIKit
import SwiftUI

class AnimalsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var animalSearch: UISearchBar!
    
    @IBOutlet weak var animalListCollection: UICollectionView!
    var animalList = [AnimalsList]()
    var animalListOriginal = [AnimalsList]()
    
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCollectionViewCell", for: indexPath) as! AnimalCollectionViewCell
        cell.animalImg.image = UIImage(named: animalList[indexPath.item].image ?? "")
        cell.animalName.text = animalList[indexPath.item].animal
        cell.tag = indexPath.item
        // about animal page yarat sonra
        cell.animalListCallBack = { index in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnimalInfoViewController") as! AnimalInfoViewController
            vc.animalsInfo = self.animalList[index].about
            self.navigationController?.present(vc, animated: true)
        }
        return cell
    }
    
    func searchAnimal(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            animalList = animalListOriginal
        } else {
            animalList = animalListOriginal.filter({ item in
                item.animal?.contains(searchText) ?? false
            })
        }
        animalListCollection.reloadData()
    }

}
