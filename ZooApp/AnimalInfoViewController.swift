//
//  AnimalInfoViewController.swift
//  ZooApp
//
//  Created by Minaya Yagubova on 26.03.23.
//

import UIKit

class AnimalInfoViewController: UIViewController {
    var animalsInfo: AboutAnimal?


    @IBOutlet weak var aboutAnimal: UITextView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutAnimal.text = animalsInfo?.about
        animalName.text = animalsInfo?.name
        animalImg.image = UIImage(named: animalsInfo?.image ?? "")

    }

}
