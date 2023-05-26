//
//  Events.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 25/05/2023.
//

import Foundation

class EventsResponse: Decodable {
    var success: String?
    var result: [Event]?
}

class Event: Decodable {
    var event_date: String?
    var event_time: String?
    
    var event_first_player: String?
    var event_home_team: String?
    var home_team_logo: String?
    var event_first_player_logo: String?
    
    var event_second_player: String?
    var away_home_team: String?
    var away_team_logo: String?
    var event_second_player_logo: String?
    
    var event_final_result: String?
    
    var country_logo: String?
    
}
