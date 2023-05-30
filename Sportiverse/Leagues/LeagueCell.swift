//
//  LeagueCell.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 21/05/2023.
//

import UIKit
import SDWebImage
import Lottie

class LeagueCell: UITableViewCell {
    
    @IBOutlet weak var leagueLogo: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet var animatedButton: LottieAnimationView!
    private var league: League!
    private var onFavoriteClicked: ((League) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAnimationView()
    }
    
    private func setupAnimationView() {
        animatedButton = LottieAnimationView()
    }
    
    func populateCell(with league: League, placeHolder: String, onFavoriteClicked: @escaping (League) -> Void){
        self.onFavoriteClicked = onFavoriteClicked
        self.league = league
        
        leagueName.text = league.league_name ?? league.country_name
        leagueLogo.sd_setImage(with: URL(string: league.league_logo ?? ""), placeholderImage: UIImage(named: placeHolder.lowercased()))
        
        leagueLogo.makeRounded()
        setupAnimatedButton()
    }
    
    private func setupAnimatedButton(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleFav))
        animatedButton.addGestureRecognizer(tapGesture)
        
        animatedButton.animation = LottieAnimation.named("heart_anim")
        if league.isFavorite {
            animatedButton.play(fromProgress: 0.7, toProgress: 0.7, loopMode: .playOnce)
        } else {
            animatedButton.play(fromProgress: 0, toProgress: 0, loopMode: .playOnce)
        }
    }
    
    @objc
    func toggleFav(){
        onFavoriteClicked(league)
        print("cell button \(league.isFavorite)")
        print("cell button Tappy Tap")
        if league.isFavorite {
            animatedButton.play(fromProgress: 0, toProgress: 0.7, loopMode: .playOnce)
        } else {
            animatedButton.play(fromProgress: 0.7, toProgress: 0, loopMode: .playOnce)
        }
    }
}


