//
//  PlayerCell.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 30/05/2023.
//

import UIKit
import SDWebImage
class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func populate(with player:Player){
        nameLabel.text = player.player_name
        typeLabel.text = player.player_type
        matchesLabel.text = player.player_match_played
        ageLabel.text = player.player_age ?? "N/A"
        playerNumberLabel.text = player.player_number ?? "N/A"
        goalsLabel.text = player.player_goals
        playerImage.sd_setImage(with: URL(string: player.player_image ?? ""), placeholderImage: UIImage(named: "unlocked_character"))
        playerImage.makeRounded()
    }
    
}
