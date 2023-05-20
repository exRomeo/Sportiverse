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
        setupShadow()
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setupAnimationView()
        setupShadow()
    }

    private func setupAnimationView(){
        animatedImage = LottieAnimationView()
        
        
    
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 2, height: 3)
//        self.layer.shadowColor = UIColor.red.cgColor
//        self.layer.shadowRadius = 15
//        self.layer.shadowOpacity = 1
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
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


