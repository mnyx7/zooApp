//
//  OnboardingCellCollectionViewCell.swift
//  ZooApp
//
//  Created by Minaya Yagubova on 07.03.23.
//

import UIKit

class OnboardingCellCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingViewController.self)
    
    @IBOutlet weak var textSlider: UILabel!
    @IBOutlet weak var imgSlider: UIImageView!
    @IBOutlet weak var titleSlider: UILabel!
    
//    func setup (_ slide: OnboardingSlide){
//        titleSlider.text = slide.title
//        textSlider.text = slide.text
//        imgSlider.image = slide.image
//    }
}

