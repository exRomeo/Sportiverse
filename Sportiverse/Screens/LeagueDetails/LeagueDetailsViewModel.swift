//
//  LeagueDetailsViewModel.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 26/05/2023.
//

import Foundation

class LeagueDetailsViewModel {
    
    private var players = [Team]()
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
    
    private let repository: IRepository
    var sportType: String
    var leagueID: Int
    private let onUpComingUpdated: (Result<[Event], Error>) -> ()
    private let onLiveScoreUpdated: (Result<[Event], Error>) -> ()
    private let onTeamsUpdated: (Result<[Team], Error>) -> ()
    
    init(repository: IRepository,sportType: String, leagueID:Int, onUpComingUpdated: @escaping (Result<[Event], Error>) -> Void, onLiveScoreUpdated: @escaping (Result<[Event], Error>) -> Void, onTeamsUpdated: @escaping (Result<[Team], Error>) -> Void) {
        self.repository = repository
        self.sportType = sportType.lowercased()
        self.leagueID = leagueID
        self.onUpComingUpdated = onUpComingUpdated
        self.onLiveScoreUpdated = onLiveScoreUpdated
        self.onTeamsUpdated = onTeamsUpdated
    }
    
    func getLeagueDetails(){
        repository.getUpcomingEvents(of: sportType, leagueID: leagueID, from: DateUtil().getTimeRange().startDate, to: DateUtil().getTimeRange().endDate) {
            self.upComingEvents = $0
            self.extractPlayers(from: $0)
        }
        
        repository.getLivescores(of: sportType, leagueID: leagueID) {
            self.liveScore = $0
            self.extractPlayers(from: $0)
        }
        if sportType != "tennis" {
            repository.getTeams(of: sportType, leagueID: leagueID) {
                self.teams = $0
            }
        }
    }
    
    private func extractPlayers(from result:Result <[Event], Error>){
        if sportType == "tennis"{
            switch result{
            case .success(let events):
            for event in events {
                players.append(Team(name: event.eventFirstPlayer ?? "", logo: event.eventFirstPlayerLogo ?? ""))
                players.append(Team(name: event.eventSecondPlayer ?? "", logo: event.eventSecondPlayerLogo ?? ""))
            }
            teams = .success(players)
            default:
                break
            }
        }
    }
}
