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
    private let repository: IRepository
    private let onStateUpdated: (Result<[League], Error>) -> ()
    let sportType: String
    
    init(repository: IRepository, sportType: String, onStateUpdated: @escaping (Result<[League], Error>) -> ()) {
        self.repository = repository
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
        repository.getLeagues(of: sportType) {
            self.updateState($0)
        }
    }
    private func getLeaguesFromDataBase() {
        repository.getAllLeagues(filteredBy: sportType) {
            updateState($0)
        }
    }
    
    
    private func updateState(_ result: Result<[League], Error>){
        switch result {
        case .success(_):
            repository.commitChangesToDatabase()
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
        repository.commitChangesToDatabase()
    }
}
