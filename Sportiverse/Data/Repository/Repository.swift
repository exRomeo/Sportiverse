//
//  Repository.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 31/05/2023.
//

import Foundation

class Repository: IRepository {
    private let api: APIService
    private let db: IDatabase
    
    init(api: APIService, db: IDatabase) {
        self.api = api
        self.db = db
    }
    
    func getAllLeagues(filteredBy sportType: String?, onCompletion: ([League]) -> Void) {
        db.getAllLeagues(filteredBy: sportType, onCompletion: onCompletion)
    }
    
    func getAllFavorites(onCompletion: ([League]) -> Void) {
        db.getAllFavorites(onCompletion: onCompletion)
    }
    
    func remove(league: League){
        db.remove(league: league)
    }
    
    func commitChangesToDatabase(){
        db.commit()
    }
    
    func getLeagues(of name: String, onCompletion: @escaping (Result<[League], Error>) -> Void) {
        api.getLeagues(of: name, onCompletion: onCompletion)
    }
    
    func getUpcomingEvents(of sportType: String, leagueID: Int, from startDate: String, to endDate: String, onCompletion: @escaping (Result<[Event], Error>) -> Void) {
        api.getUpcomingEvents(of: sportType, leagueID: leagueID, from: startDate, to: endDate, onCompletion: onCompletion)
    }
    
    func getLivescores(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Event], Error>) -> Void) {
        api.getLivescores(of: sportType, leagueID: leagueID, onCompletion: onCompletion)
    }
    
    func getTeams(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Team], Error>) -> Void) {
        api.getTeams(of: sportType, leagueID: leagueID, onCompletion: onCompletion)
    }
    
    
}
