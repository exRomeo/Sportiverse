//
//  API.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 20/05/2023.
//

import Foundation
import UIKit
import CoreData

class AllSportsAPIService :APIService {
    private let baseURL = "https://apiv2.allsportsapi.com/"
    private let apiKey = "48422a8f49fb7d10f0f909621d840392f5abdcb5a7a96f8164d7402326a1abc5"
    private static var shared: AllSportsAPIService? = nil
    private let decoder: DecoderUtil
    private var context: NSManagedObjectContext!
    
    private init(decoder: DecoderUtil) {
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.decoder = decoder
    }
    
    static func getInstance(decoder: DecoderUtil) -> AllSportsAPIService{
        if shared == nil {
            shared = AllSportsAPIService(decoder: decoder)
        }
        return shared!
    }
    // MARK: - Leagues
    
    func getLeagues(of name: String, onCompletion: @escaping (Result<[League], Error>) -> Void) {
        let urlString = "\(baseURL)\(name.lowercased())/?met=Leagues&APIkey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(APIError.noResponse))
                return
            }
            
            onCompletion(self.decoder.decodeLeagues(from: data, type: name, context: self.context))
        }
        
        task.resume()
    }
    
    // MARK: - Events
    
    func getUpcomingEvents(of sportType: String, leagueID: Int, from startDate: String, to endDate: String, onCompletion: @escaping (Result<[Event], Error>) -> Void) {
        let urlString = "\(baseURL)\(sportType.lowercased())/?met=Fixtures&APIkey=\(apiKey)&from=\(startDate)&to=\(endDate)&leagueId=\(leagueID)"
                guard let url = URL(string: urlString) else {
            onCompletion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(APIError.noResponse))
                return
            }
            
            onCompletion(self.decoder.decodeEvents(from: data))
        }
        
        task.resume()
    }
    
    func getLivescores(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Event], Error>) -> Void) {
        
        var urlString = ""
        if sportType != "tennis"{
            urlString = "\(baseURL)\(sportType.lowercased())/?met=Livescore&APIkey=\(apiKey)&leagueId=\(leagueID)"
        } else {
            urlString = "\(baseURL)\(sportType.lowercased())/?met=Livescore&APIkey=\(apiKey)"
        }
        print(urlString)
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(APIError.noResponse))
                return
            }
            
            onCompletion(self.decoder.decodeEvents(from: data))
        }
        
        task.resume()
    }
    
    // MARK: - Teams
    
    func getTeams(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Team], Error>) -> Void) {
        let urlString = "\(baseURL)\(sportType.lowercased())/?met=Teams&APIkey=\(apiKey)&leagueId=\(leagueID)"
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(APIError.noResponse))
                return
            }
            
            onCompletion(self.decoder.decodeTeams(from: data))
        }
        
        task.resume()
    }
}

extension AllSportsAPIService {
    enum APIError: String, Error {
        case invalidUrl = "URL is invalid!"
        case noResponse = "Recieved no response!"
        case emptyList = "Found no results"
    }
}

