//
//  LeagueDetailsViewModel.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 26/05/2023.
//

import Foundation

class LeagueDetailsViewModel {
    
    private var upComingEvents: Result<[Event], Error>!  {
        didSet {
            onUpComingUpdated(upComingEvents)
        }
    }
    private var liveScore: Result<[Event], Error>!  {
        didSet {
            onUpComingUpdated(upComingEvents)
        }
    }
    private var teams: Result<[Team], Error>!  {
        didSet {
            onUpComingUpdated(upComingEvents)
        }
    }
    
//    private let db: Database
    private let api: API
    private let onUpComingUpdated: (Result<[Event], Error>) -> ()
    private let onLiveScoreUpdated: (Result<[Event], Error>) -> ()
    private let onTeamsUpdated: (Result<[Event], Error>) -> ()
    
    init(upComingEvents: Result<[Event], Error>!, liveScore: Result<[Event], Error>!, teams: Result<[Team], Error>!, api: API, onUpComingUpdated: @escaping (Result<[Event], Error>) -> Void, onLiveScoreUpdated: @escaping (Result<[Event], Error>) -> Void, onTeamsUpdated: @escaping (Result<[Event], Error>) -> Void) {
        self.upComingEvents = upComingEvents
        self.liveScore = liveScore
        self.teams = teams
        self.api = api
        self.onUpComingUpdated = onUpComingUpdated
        self.onLiveScoreUpdated = onLiveScoreUpdated
        self.onTeamsUpdated = onTeamsUpdated
    }
}
