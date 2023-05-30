//
//  TopCollectionViewCell.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 26/05/2023.
//

import UIKit
import SDWebImage
class TopCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.purple.withAlphaComponent(0.25).cgColor
    }
    
    
    func populateCell(with event:Event, placeHolder: String){
        score.text = event.eventFinalResult
        homeTeamName.text = event.eventHomeTeam
        awayTeamName.text = event.eventAwayTeam
        matchDate.text = event.eventDate
        time.text = event.eventTime
        homeTeamImage.sd_setImage(with: URL(string:event.homeTeamLogo ?? ""), placeholderImage: UIImage(named: placeHolder))
        homeTeamImage.makeRounded()
        awayTeamImage.sd_setImage(with: URL(string:event.awayTeamLogo ?? ""), placeholderImage: UIImage(named: placeHolder))
        awayTeamImage.makeRounded()
        

    }
}
