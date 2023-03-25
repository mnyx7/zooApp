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
        
        cell.tag = indexPath.item
        //????
        cell.aboutZooCallBack = { index in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutZooViewController") as! AboutZooViewController
            vc.aboutZoo = self.zooList[index].about
            self.navigationController?.present(vc, animated: true)
        }
        //        login olmayibsa login sehifesine kechsin, olubsa favorite ya da evvelki sehifeye atsin
                cell.favZooCallBack = {
                    if UserDefaults.standard.bool(forKey: "loggedIn") {
                        print("hi")
                    } else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        self.navigationController?.show(vc, sender: nil)
                    }
                }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.frame.width, height: 150)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnimalsViewController") as! AnimalsViewController
        vc.animalList = zooList[indexPath.item].animals ?? []
        navigationController?.show(vc, sender: nil)
    }
    
}
