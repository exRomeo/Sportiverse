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
    
    private let repository: IRepository
    private let onStateUpdated: (Result<[League], Error>) -> ()
    
    var isConnected:Bool {
        let reachability = try? Reachability()
        return reachability?.connection != .unavailable
    }
    
    init(repository: IRepository, onStateUpdated: @escaping (Result<[League], Error>) -> ()) {
        self.repository = repository
        self.onStateUpdated = onStateUpdated
    }
    
    func fetchLeagues() {
        repository.getAllFavorites(){
            self.updateState($0)
        }
    }
    
    private func updateState(_ leagues: [League]){
        if leagues.count == 0 {
            state = .failure(AllSportsAPIService.APIError.emptyList)
        } else {
            state = .success(leagues)
        }
    }
    
    func toggleFavorite(league: League){
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.55){
            league.isFavorite.toggle()
            self.repository.commitChangesToDatabase()
            self.fetchLeagues()
        }
    }
}
