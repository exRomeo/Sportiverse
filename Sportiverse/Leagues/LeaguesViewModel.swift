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
    private let sportType: String
    
    init(db: Database, api: API, sportType: String, onStateUpdated: @escaping (Result<[League], Error>) -> ()) {
        self.db = db
        self.api = api
        self.sportType = sportType
        self.onStateUpdated = onStateUpdated
    }
    
    func fetchLeagues(){
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
            db.getAllLeagues(filteredBy: sportType) {
                updateState($0)
            }
            api.getLeagues(of: sportType) {
                self.updateState($0)
            }
        } else {
            db.getAllLeagues(filteredBy: sportType) {
                updateState($0)
            }
        }
    }
    
    
    private func updateState(_ result: Result<[League], Error>){
        switch result {
        case .success(_):
            db.commit()
            db.getAllLeagues(filteredBy: sportType) {
                updateState($0)
            }
        case .failure(_):
            state = result
        }
    }
    
    private func updateState(_ leagues: [League]){
        if leagues.count == 0 {
//            state = .failure(NSError(domain: "empty array", code: 0, userInfo: [NSLocalizedDescriptionKey: "list is empty"]))
        } else {
            state = .success(leagues)
        }
    }
    
    func toggleFavorite(league: League){
        league.isFavorite.toggle()
        db.commit()
        onStateUpdated(state)
    }
}
