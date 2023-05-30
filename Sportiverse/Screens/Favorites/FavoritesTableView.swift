//
//  ViewController.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 19/05/2023.
//

import UIKit

class FavoritesTableView: UITableViewController {
    
    private let cellIdentifier = "leagueCell"
    private var leagues = [League]()
    private var viewModel: favoritesViewModel!
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    override func viewWillAppear(_ animated: Bool) {
        for subView in view.subviews{
            subView.removeFromSuperview()
        }
        startActivityIndicator()
        viewModel.fetchLeagues()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UILabel().make(title: "Favorites")
        viewModel = favoritesViewModel(db: Database.instance) { [weak self] result in self?.renderData(result)
        }
        
        setupView()
    }
    
    private func setupView(){
        let gestureRec = UISwipeGestureRecognizer(target: self, action:#selector(rightSwipeHandler))
        gestureRec.direction = .right
        self.view.addGestureRecognizer(gestureRec)
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func startActivityIndicator(){
        activityIndicator.color = .blue
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    @objc
    func rightSwipeHandler(){
        tabBarController?.selectedIndex = tabBarController!.selectedIndex - 1
    }
    
    // MARK: - Render Data On UI
    
    func renderData(_ result: Result<[League], Error>){
        DispatchQueue.main.async { [weak self] in
            switch result {
                
            case .failure(_):
                    self?.showEmptyListMessage()
                
            case .success(let leagues):
                self?.showLeagues(leagues)
            }
        }
    }
    
    // MARK: - User has no favorites
    
    func showEmptyListMessage(){
        activityIndicator.stopAnimating()
        leagues = [League]()
        tableView.reloadData()
        
        UILabel().showMessage("Add Some Leagues To Favorites", with: .lightGray, on: view)
    }
    
    // MARK: - Success State
    func showLeagues(_ leagues: [League]){
        self.leagues = leagues
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
}

internal extension FavoritesTableView {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeagueCell
        let league = leagues[indexPath.row]
        cell.populateCell(with: league, placeHolder: league.sportType!)
        { [weak self] in
            self?.viewModel.toggleFavorite(league: $0)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.isConnected {
            
            let leagueDetails = storyboard?.instantiateViewController(withIdentifier: "leagueDetailsScreen") as! LeagueDetails
            leagueDetails.instantiateViewModel(with: Int(leagues[indexPath.row].league_key ), and: leagues[indexPath.row].sportType!)
            navigationController?.pushViewController(leagueDetails, animated: true)
            
        } else {
            
            UIAlertController.showNoInternetDialog(from: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

