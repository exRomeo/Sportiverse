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
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var leagues = [League]()
    var viewModel: LeaguesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UILabel().make(title: viewModel.sportType)
        
        activityIndicator.addIndicator(to: view)
        
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        viewModel.fetchLeagues()
    }
    
    
    func instantiateViewModel(sportType: String){
        let repository : IRepository = (UIApplication.shared.delegate as! AppDelegate).repository
        viewModel = LeaguesViewModel(repository: repository, sportType: sportType){ [weak self] result in self?.renderData(result)
        }
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
        activityIndicator.stopAnimating()
        print(error.localizedDescription)
        UILabel().show(errorMessage: error, on: view)
        // TODO: show the user there is a freakin error *_*
    }
    
    // MARK: - Success State
    func showLeagues(_ leagues: [League]){
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
        return leagues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeagueCell
        let league = leagues[indexPath.row]
        
        cell.populateCell(with: league, placeHolder: viewModel.sportType.lowercased())
        { [weak self] in
            self?.viewModel.toggleFavorite(league: $0)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isConnected {
            let leagueDetails = storyboard?.instantiateViewController(withIdentifier: "leagueDetailsScreen") as! LeagueDetails
            leagueDetails.instantiateViewModel(with: Int(leagues[indexPath.row].league_key ), and: viewModel.sportType)
            navigationController?.pushViewController(leagueDetails, animated: true)
        } else {
            UIAlertController.showNoInternetDialog(from: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
