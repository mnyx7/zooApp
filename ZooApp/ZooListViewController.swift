import UIKit
import SwiftUI

class ZooListViewController: UIViewController  {
    @IBOutlet weak var zooListCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var gridButtonOutlet: UIButton!
    @IBAction func gridToList(_ sender: Any) {
        
        isgrid = !isgrid
        let imageName = isgrid ? "square.grid.3x1.below.line.grid.1x2" : "list.bullet"
        gridButtonOutlet.setImage(UIImage(systemName: imageName),
                               for: .normal)
        zooListCollection.reloadData()
    }
    var zooList = [ZooList]()
    //dublicate for search
    var zooListOriginal = [ZooList]()
    //listGrid
    var isgrid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        jsonFileRead()
    }
    
    func jsonFileRead(){
        if let jsonFile = Bundle.main.url(forResource: "zooList", withExtension: "json"){
            let data = (try? Data(contentsOf: jsonFile))!
            do {
                zooList = try JSONDecoder().decode([ZooList].self, from: data)
                zooListOriginal = zooList
                zooListCollection.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            print(jsonFile)
        }
    }
}

extension ZooListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        zooList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooListCollectionViewCell", for: indexPath) as! ZooListCollectionViewCell
        cell.zooName.text = zooList[indexPath.item].name
        cell.zooInfo.text = zooList[indexPath.item].info
        cell.zooRating.text = "\(zooList[indexPath.item].rating ?? Double())"
        
        cell.tag = indexPath.item
        //????
        cell.aboutZooCallBack = { index in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutZooViewController") as! AboutZooViewController
            vc.aboutZoo = self.zooList[index].about
            self.navigationController?.present(vc, animated: true)
        }
        //        if not loged in yet
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                zooList = zooListOriginal
            } else {
                zooList = zooListOriginal.filter({ item in
                    item.name?.contains(searchText) ?? false
                })
            }
        zooListCollection.reloadData()
        }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return  CGSize(width: collectionView.frame.width, height: 150)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isgrid {
            return CGSize(width: collectionView.frame.width / 2 - 10, height: 200)
        }
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnimalsViewController") as! AnimalsViewController
        vc.animalList = zooList[indexPath.item].animal ?? []
        navigationController?.show(vc, sender: nil)
    }
    
}
