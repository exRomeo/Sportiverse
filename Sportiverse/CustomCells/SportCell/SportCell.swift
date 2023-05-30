//
//  SportCell.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 19/05/2023.
//

import UIKit
import Lottie

class SportCell: UICollectionViewCell {
    
   
    @IBOutlet var animatedImage: LottieAnimationView!
    
    @IBOutlet weak var sportTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAnimationView()
        setupCellBorder()
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setupAnimationView()
        setupCellBorder()
    }

    private func setupAnimationView(){
        animatedImage = LottieAnimationView()
    }
    
    private func setupCellBorder() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configureAnimation(with animationName: String) {

        animatedImage.animation = LottieAnimation.named(animationName)
            animatedImage.contentMode = .scaleAspectFit
            animatedImage.loopMode = .loop
            animatedImage.play()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animatedImage.stop()
        animatedImage.animation = nil
    }
    
}


