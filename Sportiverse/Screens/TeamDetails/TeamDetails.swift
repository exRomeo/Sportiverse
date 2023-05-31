//
//  TeamDetails.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 30/05/2023.
//

import Foundation
import UIKit
import SDWebImage

class TeamDetails : UIViewController {
    @IBOutlet weak var teamLogo: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private let reusableCellIdentifier = "playerCell"
    private var viewModel:TeamDetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UILabel().make(title: viewModel.team.team_name ?? "")
        tableView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellReuseIdentifier: reusableCellIdentifier)
        teamLogo.sd_setImage(with: URL(string: viewModel.team.team_logo ?? ""), placeholderImage: UIImage(named: "football"))
        teamLogo.makeRounded()
        tableView.reloadData()
    }
    
    func instantiateViewModel(team:Team){
        viewModel = TeamDetailsViewModel(team: team)
    }
    
}


extension TeamDetails: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.team.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath) as! PlayerCell
        cell.populate(with:viewModel.team.players![indexPath.row])
        return cell
    }
}


extension TeamDetails {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let imageViewHeight = max(teamLogo.frame.height - offsetY, 100)
        
        teamLogo.constraints.forEach { constraint in
            if constraint.firstAttribute == .height{
                constraint.constant = imageViewHeight
            }
        }
    }
}

