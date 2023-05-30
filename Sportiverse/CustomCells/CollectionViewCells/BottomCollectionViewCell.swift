//
//  BottomCollectionViewCell.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 28/05/2023.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
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
    
    
    func populateCell(team: Team, placeHolder: String){
        teamName.text = team.team_name
        teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""), placeholderImage: UIImage(named: placeHolder))
        teamImage.makeRounded()
    }

}
