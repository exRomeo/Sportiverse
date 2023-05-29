//
//  LeaguesView.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 20/05/2023.
//

import UIKit
import Reachability

class LeaguesView: UITableViewController {
    let cellIdentifier = "leagueCell"
    var sportName = ""
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var leagues = [League]()
    var viewModel: LeaguesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LeaguesViewModel(db: Database.instance, api: API.shared, sportType: sportName){ [weak self] result in self?.renderData(result)
        }
        navigationItem.titleView = UILabel().make(title: sportName)
        
        activityIndicator.color = .blue
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        viewModel.fetchLeagues()
    }
    
    // MARK: - Render Data On UI
    
    func renderData(_ result: Result<[League], Error>){
        DispatchQueue.main.async { [weak self] in
            switch result {
                
            case .failure(let error):
                self?.showError(error)
                
            case .success(let leagues):
                self?.showLeagues(leagues)
                
            }
        }
    }
    
    // MARK: - Error state
    
    func showError(_ error: Error){
        print("errored out ?")
        activityIndicator.stopAnimating()
        print(error.localizedDescription)
        UILabel().show(errorMessage: error, on: view)
        // TODO: show the user there is a freakin error *_*
    }
    
    // MARK: - Success State
    func showLeagues(_ leagues: [League]){
        print("showing leagues !!!")
        self.leagues = leagues
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
}




internal extension LeaguesView {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeagueCell
        let league = leagues[indexPath.row]
        
        cell.populateCell(with: league, placeHolder: sportName.lowercased())
        { [weak self] in
            self?.viewModel.toggleFavorite(league: $0)
        }
        print("\(league.league_name ?? league.country_name ?? "no league nor country name ?!")")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetails = storyboard?.instantiateViewController(withIdentifier: "leagueDetailsScreen") as! LeagueDetails
        leagueDetails.instantiateViewModel(with: Int(leagues[indexPath.row].league_key ), and: sportName)
        navigationController?.pushViewController(leagueDetails, animated: true)
        
    }
}
