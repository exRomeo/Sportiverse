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
    var sportName = "Leagues"
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var leagues: Array<Dictionary<String, Any>> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = UILabel()
        title.text = sportName.appending(" Leagues")
        title.font = UIFont.boldSystemFont(ofSize: 28)
        navigationItem.titleView = title
        
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
            getDataFromAPI()
        }
                
    }
    
    // MARK: - Get Data From URL
    
    func getDataFromAPI(){
        let urlString = "https://apiv2.allsportsapi.com/\(sportName.lowercased())/?met=Leagues&APIkey=\(API.apiKey)"
        print(urlString)
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            do {
                if let data {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                    self.leagues = json["result"] as! Array<Dictionary<String, Any>>
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                        print(self.leagues.count)
                    }
                    
                } else {
                    print("Error Couldn't Retrieve Data")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        print(league["league_name"] as! String)
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
