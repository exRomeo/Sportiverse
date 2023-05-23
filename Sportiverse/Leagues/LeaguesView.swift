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
    var url = ""
    var sportName = ""
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var leagues = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UILabel().make(title: sportName)
        
        activityIndicator.color = .blue
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            activityIndicator.stopAnimating()
            let label = UILabel()
            label.text = "No Connection!"
            label.center = view.center
            view.addSubview(label)
        } else {
            getLeagues()
        }
                
    }
    
    // MARK: - Get Data From URL
    
    func getLeagues(){
        API.instance.getLeagues(of: sportName){ [weak self] result in
            self?.renderData(result)
            print("api closure")
        }
    }
 
    
    
    func renderData(_ result: Result<LeaguesResponse, Error>){
        DispatchQueue.main.async { [weak self] in
            switch result {
                
            case .failure(let error):
                self?.showError(error)
                
            case .success(let leaguesResponse):
                if leaguesResponse.result!.isEmpty{
                    self?.showError(NSError(domain: "local", code: 0, userInfo: [NSLocalizedDescriptionKey: "Add Some To Favorites :DDD"]))
                } else {
                    self?.showLeagues(leaguesResponse.result!)
                }
            }
        }
        
    }
    
    func showError(_ error: Error){
        print("errored out ?")
        activityIndicator.stopAnimating()
        print(error.localizedDescription)
        UILabel().show(errorMessage: error, on: view)
        // TODO: show the user there is a freakin error *_*
    }
    
    
    func showLeagues(_ leagues: [League]){
        print("showing leagues !!!")
        self.leagues = leagues
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
}


extension UILabel {
    func show(errorMessage error:Error, on view: UIView){
        text = error.localizedDescription
        textAlignment = .center
        textColor = .systemRed
        font = UIFont.boldSystemFont(ofSize: 28)
        view.addSubview(self)
        numberOfLines = 2
        frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    func make(title:String) -> UILabel {
        text = title
        font = UIFont.boldSystemFont(ofSize: 28)
        return self
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
        print("\(league.league_name ?? league.country_name ?? "no league nor country name ?!")")
        
        return cell
    }
}
