//
//  APIProtocol.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 01/06/2023.
//

import Foundation


protocol APIService {
    
    // MARK: - Leagues
    func getLeagues(of name: String, onCompletion: @escaping (Result<[League], Error>) -> Void)
    
    // MARK: - Events
    
    func getUpcomingEvents(of sportType: String, leagueID: Int, from startDate: String, to endDate: String, onCompletion: @escaping (Result<[Event], Error>) -> Void)
    
    func getLivescores(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Event], Error>) -> Void)
    
    // MARK: - Teams
    
    func getTeams(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Team], Error>) -> Void)
}
