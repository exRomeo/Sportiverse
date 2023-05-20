//
//  LeagueCell.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 21/05/2023.
//

import UIKit
import SDWebImage

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueLogo: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(with league: [String: Any], placeHolder: String){
        leagueName.text = (league["league_name"] as! String)
        leagueLogo.sd_setImage(with: URL(string: league["league_logo"] as? String ?? ""), placeholderImage: UIImage(named: placeHolder))
        leagueLogo.makeRounded()
    }
}


extension UIImageView {
    func makeRounded(){
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = frame.width/2
        contentMode = .scaleAspectFit
    }
}
