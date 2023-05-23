//
//  API.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 20/05/2023.
//

import Foundation

//https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=48422a8f49fb7d10f0f909621d840392f5abdcb5a7a96f8164d7402326a1abc5
//https://apiv2.allsportsapi.com/football/?met=Leagues&APIKey=48422a8f49fb7d10f0f909621d840392f5abdcb5a7a96f8164d7402326a1abc5
class API {
    private let baseURL = "https://apiv2.allsportsapi.com/"
    private let apiKey = "48422a8f49fb7d10f0f909621d840392f5abdcb5a7a96f8164d7402326a1abc5"
    private let football = "football/"
    private let basketball = "basketball/"
    private let cricket = "cricket/"
    private let tennis = "tennis/"
    private let leagues = "Leagues"
    static let instance = API()
    
    private init(){}
    
    func getLeagues(of name:String, onCompletion: @escaping (Result<LeaguesResponse, Error>) -> Void){
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
                onCompletion((self.decodeLeagues(from: data)))
            }
        }
        task.resume()
    }
    
    private func decodeLeagues(from data: Data) -> Result<LeaguesResponse, Error> {
        let decoder = JSONDecoder()
        print("decoder")
        do {
            let response: LeaguesResponse = try decoder.decode(LeaguesResponse.self, from: data)
            return .success(response)
        } catch {
            print("error decoding ?!")
            return .failure(error)
        }
    }
    
    func getTeams(){
        
    }
    
}
