//
//  LeagueDetailsViewModel.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 26/05/2023.
//

import Foundation

class LeagueDetailsViewModel {
    
    
    private var upComingEvents: Result<[Event], Error>! {
        didSet {
            onUpComingUpdated(upComingEvents)
        }
    }
    private var liveScore: Result<[Event], Error>! {
        didSet {
            onLiveScoreUpdated(liveScore)
        }
    }
    private var teams: Result<[Team], Error>! {
        didSet {
            onTeamsUpdated(teams)
        }
    }
    
//    private let db: Database
    private let api: API
    var sportType: String
    var leagueID: Int
    private let onUpComingUpdated: (Result<[Event], Error>) -> ()
    private let onLiveScoreUpdated: (Result<[Event], Error>) -> ()
    private let onTeamsUpdated: (Result<[Team], Error>) -> ()
    
    init(api: API,sportType: String, leagueID:Int, onUpComingUpdated: @escaping (Result<[Event], Error>) -> Void, onLiveScoreUpdated: @escaping (Result<[Event], Error>) -> Void, onTeamsUpdated: @escaping (Result<[Team], Error>) -> Void) {
        self.api = api
        self.sportType = sportType.lowercased()
        self.leagueID = leagueID
        self.onUpComingUpdated = onUpComingUpdated
        self.onLiveScoreUpdated = onLiveScoreUpdated
        self.onTeamsUpdated = onTeamsUpdated
    }
    
    func getLeagueDetails(){
        api.getUpcomingEvents(of: sportType, leagueID: leagueID, from: DateUtil().getTimeRange().startDate, to: DateUtil().getTimeRange().endDate) {
            self.upComingEvents = $0
        }
        
        api.getLivescores(of: sportType, leagueID: leagueID) {
            self.liveScore = $0
        }
        
        api.getTeams(of: sportType, leagueID: leagueID) {
            self.teams = $0
        }
    }

}
