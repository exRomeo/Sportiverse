//
//  API.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 20/05/2023.
//

import Foundation
import UIKit
import CoreData

class API {
    private let baseURL = "https://apiv2.allsportsapi.com/"
    private let apiKey = "48422a8f49fb7d10f0f909621d840392f5abdcb5a7a96f8164d7402326a1abc5"
    static let shared = API()
    
    private var context: NSManagedObjectContext!
      private init(){
          self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      }
    

    
    // MARK: - Leagues
    
    func getLeagues(of name: String, onCompletion: @escaping (Result<[League], Error>) -> Void) {
        let urlString = "\(baseURL)\(name.lowercased())/?met=Leagues&APIkey=\(apiKey)"
        print("get Leagues from \(urlString)")
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("URL session error -> \(error.localizedDescription)")
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(APIError.noResponse))
                return
            }
            
            onCompletion(self.decodeLeagues(from: data, type: name))
        }
        
        task.resume()
    }
    
    private func decodeLeagues(from data: Data, type: String) -> Result<[League], Error> {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.context] = context
        decoder.userInfo[CodingUserInfoKey.sportType] = type
        
        print("decoder working on Leagues")
        do {
            let response: LeaguesResponse = try decoder.decode(LeaguesResponse.self, from: data)
            guard let result = response.result else {
                return .failure(APIError.emptyList)
            }
            return .success(result)
        } catch {
            print("decoder error -> \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    // MARK: - Events
    
    func getUpcomingEvents(of sportType: String, leagueID: Int, from startDate: String, to endDate: String, onCompletion: @escaping (Result<[Event], Error>) -> Void ) {
        let urlString = "\(baseURL)\(sportType.lowercased())/?met=Fixtures&APIkey=\(apiKey)&from=\(startDate)&to=\(endDate)&leagueId=\(leagueID)"
        
        print("get League Details from = \(urlString)")
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("URL session error -> \(error.localizedDescription)")
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(APIError.noResponse))
                return
            }
            
            onCompletion(self.decodeEvents(from: data))
        }
        
        task.resume()
    }
    
    func getLivescores(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Event], Error>) -> Void ) {
        let urlString = "\(baseURL)\(sportType.lowercased())/?met=Livescore&APIkey=\(apiKey)"
        
        print("get League Details from = \(urlString)")
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("URL session error -> \(error.localizedDescription)")
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(APIError.noResponse))
                return
            }
            
            onCompletion(self.decodeEvents(from: data))
        }
        
        task.resume()
    }
    
    private func decodeEvents(from data: Data) -> Result<[Event], Error> {
        let decoder = JSONDecoder()
        print("decoding events")
        do {
            let response: EventsResponse = try decoder.decode(EventsResponse.self, from: data)
            guard let result = response.result else {
                return .failure(APIError.emptyList)
            }
            return .success(result)
        } catch {
            print("decoder error -> \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    // MARK: - Teams
    
    func getTeams(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Team], Error>) -> Void ) {
        let urlString = "\(baseURL)\(sportType.lowercased())/?met=Teams&APIkey=\(apiKey)&leagueId=\(leagueID)"
        print("get Teams from = \(urlString)")
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("URL session error -> \(error.localizedDescription)")
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(APIError.noResponse))
                return
            }
            
            onCompletion(self.decodeTeam(from: data))
        }
        
        task.resume()
    }
    
    private func decodeTeam(from data: Data) -> Result<[Team], Error> {
        let decoder = JSONDecoder()
        print("Decoding Teams")
        do {
            let response: TeamsResponse = try decoder.decode(TeamsResponse.self, from: data)
            guard let result = response.result else {
                return .failure(APIError.emptyList)
            }
            return .success(result)
        } catch {
            print("decoder error -> \(error.localizedDescription)")
            return .failure(error)
        }
    }
}

extension API {
    enum APIError: String, Error {
        case invalidUrl = "URL is invalid!"
        case noResponse = "Recieved no response!"
        case emptyList = "Found no results"
    }
}

