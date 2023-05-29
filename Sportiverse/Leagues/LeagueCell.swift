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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(with league: League, placeHolder: String, onFavoriteClicked: @escaping (League) -> Void){
//    func populateCell(with league: League, placeHolder: String){
        self.onFavoriteClicked = onFavoriteClicked
        self.league = league
        leagueName.text = league.league_name ?? league.country_name
        leagueLogo.sd_setImage(with: URL(string: league.league_logo ?? ""), placeholderImage: UIImage(named: placeHolder))
        leagueLogo.makeRounded()
        
        animatedButton = LottieAnimationView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleFav))
        animatedButton.addGestureRecognizer(tapGesture)
        animatedButton.isUserInteractionEnabled = true

        animatedButton.animation = LottieAnimation.named("heart_anim")
        animatedButton.contentMode = .scaleAspectFit
        animatedButton.loopMode = .loop
        animatedButton.play()
        if league.isFavorite {
            animatedButton.play(fromFrame: animatedButton.animation?.duration ?? 0, toFrame: 0, loopMode: .playOnce){_ in}
        } else {
            animatedButton.play(fromProgress: 0, toProgress: 1, loopMode: .playOnce)
        }
    }
    
    @objc
    func toggleFav(){
        onFavoriteClicked(league)
        print(league.isFavorite)
    }
}


