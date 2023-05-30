//
//  LeaguesViewModel.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 25/05/2023.
//

import Foundation
import Reachability

class LeaguesViewModel {
    
    private var state: Result<[League], Error>! {
        didSet {
            onStateUpdated(state)
        }
    }
    private let db: Database
    private let api: API
    private let onStateUpdated: (Result<[League], Error>) -> ()
    let sportType: String
    
    init(db: Database, api: API, sportType: String, onStateUpdated: @escaping (Result<[League], Error>) -> ()) {
        self.db = db
        self.api = api
        self.sportType = sportType
        self.onStateUpdated = onStateUpdated
    }
    
    var isConnected:Bool {
        let reachability = try? Reachability()
        return reachability?.connection != .unavailable
    }
    
    func fetchLeagues(){
        getLeaguesFromDataBase()
        if isConnected {
            updateLeagues()
        }
    }
    
    private func updateLeagues(){
        api.getLeagues(of: sportType) {
            self.updateState($0)
        }
    }
    private func getLeaguesFromDataBase() {
        db.getAllLeagues(filteredBy: sportType) {
            updateState($0)
        }
    }
    
    
    private func updateState(_ result: Result<[League], Error>){
        switch result {
        case .success(_):
            db.commit()
            getLeaguesFromDataBase()
        case .failure(_):
            state = result
        }
    }
    
    private func updateState(_ leagues: [League]){
        
        state = .success(leagues)
        
    }
    
    func toggleFavorite(league: League){
        league.isFavorite.toggle()
        db.commit()
    }
}
