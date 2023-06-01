//
//  RepositoryProtocol.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 31/05/2023.
//

import Foundation

protocol IRepository {
    
    func getAllLeagues(filteredBy sportType: String?, onCompletion: ([League]) -> Void)
    
    func getAllFavorites(onCompletion: ([League]) -> Void)
    
    func remove(league: League)
    
    func commitChangesToDatabase()
    
    func getLeagues(of name: String, onCompletion: @escaping (Result<[League], Error>) -> Void)
    
    func getUpcomingEvents(of sportType: String, leagueID: Int, from startDate: String, to endDate: String, onCompletion: @escaping (Result<[Event], Error>) -> Void)
    
    func getLivescores(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Event], Error>) -> Void)
    
    func getTeams(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Team], Error>) -> Void)
}
