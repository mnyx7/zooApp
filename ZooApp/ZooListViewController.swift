import UIKit
import SwiftUI

class ZooListViewController: UIViewController  {
    @IBOutlet weak var gridToListButton: UIImageView!
    @IBOutlet weak var zooListCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var zooList = [ZooList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonFileRead()
    }
    
    @IBAction func aboutZooButton(_ sender: Any) {
        let aboutZooVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(AboutZooViewController.self)") as! AboutZooViewController
        self.navigationController?.show(aboutZooVC, sender: nil)

    }
    
    @IBAction func addToFavorites(_ sender: Any) {
    }
    
    func jsonFileRead(){
        if let jsonFile = Bundle.main.url(forResource: "zooList", withExtension: "json"){
            let data = (try? Data(contentsOf: jsonFile))!
            do {
                zooList = try JSONDecoder().decode([ZooList].self, from: data)
                zooListCollection.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            print(jsonFile)
        }
    }
}

extension ZooListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        zooList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooListCollectionViewCell", for: indexPath) as! ZooListCollectionViewCell
        cell.zooName.text = zooList[indexPath.item].name
        cell.zooInfo.text = zooList[indexPath.item].info
        cell.zooRating.text = "\(zooList[indexPath.item].rating)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.frame.width, height: 150)
    }
    
    
    
}
