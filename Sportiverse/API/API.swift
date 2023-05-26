//
//  API.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 20/05/2023.
//

import Foundation
import UIKit
import CoreData

//https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=48422a8f49fb7d10f0f909621d840392f5abdcb5a7a96f8164d7402326a1abc5&from=2023-05-25&to=2023-05-30&leagueId=322
class API {
    private let baseURL = "https://apiv2.allsportsapi.com/"
    private let apiKey = "48422a8f49fb7d10f0f909621d840392f5abdcb5a7a96f8164d7402326a1abc5"
    private let football = "football/"
    private let basketball = "basketball/"
    private let cricket = "cricket/"
    private let tennis = "tennis/"
    private let leagues = "Leagues"
    private let fixtures = "Fixtures"
    private let livescore = "Livescore"
    static let instance = API()
    private var context: NSManagedObjectContext!
    private init(){
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    //MARK: - Leagues
    
    func getLeagues(of name:String, onCompletion: @escaping (Result<[League], Error>) -> Void){
        let urlString = "\(baseURL + name.lowercased())/?met=\(leagues)&APIkey=\(apiKey)"
        print("get Leagues from \(urlString)")
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if let error = error {
                print("why erroring ? \(error.localizedDescription)")
                onCompletion(.failure(error))
            }
            if let data = data {
                onCompletion(self.decodeLeagues(from: data, type: name))
            }
        }
        task.resume()
    }
    
    private func decodeLeagues(from data: Data, type: String) -> Result<[League], Error> {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.context] = context
        decoder.userInfo[CodingUserInfoKey.sportType] = type
        
        print("decoder")
        do {
            let response: LeaguesResponse = try decoder.decode(LeaguesResponse.self, from: data)
            return .success(response.result!)
        } catch {
            print("error decoding ?!")
            return .failure(error)
        }
    }
    
    //MARK: - Eventes
    
    func getUpcomingEvents(of sportType: String, leagueID: Int, from startDate:String, to endDate:String, onCompletion: @escaping (Result<[Event], Error>) -> Void ) {
        
        let urlString = "\(baseURL + sportType.lowercased())/?met=\(fixtures)&APIkey=\(apiKey)&from=\(startDate)&to\(endDate)&leagueId=\(leagueID)"
        
        print("get League Details from = \(urlString)")
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print("why erroring ? \(error.localizedDescription)")
                onCompletion(.failure(error))
            }
            if let data = data {
                onCompletion(self.decodeLeagueDetails(from: data))
            }
        }
        task.resume()
    }
    
    func getLivescores(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Event], Error>) -> Void ) {
        
        let urlString = "\(baseURL + sportType.lowercased())/?met=\(fixtures)&APIkey=\(apiKey)&leagueId=\(leagueID)"
        
        print("get League Details from = \(urlString)")
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print("why erroring ? \(error.localizedDescription)")
                onCompletion(.failure(error))
            }
            if let data = data {
                onCompletion(self.decodeLeagueDetails(from: data))
            }
        }
        task.resume()
    }
    
    private func decodeLeagueDetails(from data: Data) -> Result<[Event], Error> {
        let decoder = JSONDecoder()
       
        print("decoder")
        do {
            let response: EventsResponse = try decoder.decode(EventsResponse.self, from: data)
            return .success(response.result!)
        } catch {
            print("error decoding ?!")
            return .failure(error)
        }
    }
    
    
    func getTeams(of sportType:String){
        //https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=48422a8f49fb7d10f0f909621d840392f5abdcb5a7a96f8164d7402326a1abc5&leagueId=322
    }
    
}
