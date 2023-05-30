//
//  FavoritesViewModel.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 30/05/2023.
//

import Foundation
import Reachability

class favoritesViewModel{
    private var state: Result<[League], Error>! {
        didSet {
            onStateUpdated(state)
        }
    }
    
    private let db: Database
    private let onStateUpdated: (Result<[League], Error>) -> ()
    
    var isConnected:Bool {
        let reachability = try? Reachability()
        return reachability?.connection != .unavailable
    }
    
    init(db: Database, onStateUpdated: @escaping (Result<[League], Error>) -> ()) {
        self.db = db
        self.onStateUpdated = onStateUpdated
    }
    
    func fetchLeagues() {
        db.getAllFavorites(){
            self.updateState($0)
        }
    }
    
    private func updateState(_ leagues: [League]){
        if leagues.count == 0 {
            state = .failure(API.APIError.emptyList)
        } else {
            state = .success(leagues)
        }
    }
    
    func toggleFavorite(league: League){
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.55){
            league.isFavorite.toggle()
            self.db.commit()
            self.fetchLeagues()
        }
    }
}
