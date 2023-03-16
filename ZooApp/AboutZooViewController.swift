//
//  AboutZooViewController.swift
//  ZooApp
//
//  Created by Minaya Yagubova on 11.03.23.
//

import UIKit

class AboutZooViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var zooInfo: UILabel!
    @IBOutlet weak var zooImg: UIImageView!
    @IBOutlet weak var zooAddress: UILabel!
    @IBOutlet weak var zooPhone: UILabel!
    var aboutZoo: AboutZooList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = aboutZoo?.name
        zooImg.image = UIImage(named: aboutZoo?.image ?? "" )
        zooInfo.text = aboutZoo?.info
        zooPhone.text = aboutZoo?.phone
        zooAddress.text = aboutZoo?.address
        
    }
    
    
    
    
}
