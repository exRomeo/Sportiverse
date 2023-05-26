//
//  TeamsResponse.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 26/05/2023.
//

import Foundation
class TeamsResponse: Decodable{
    let success: Int?
    let result: [Team]?
    
}

class Team: Decodable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
    
}

class Player: Decodable {
    let player_key: Int?
    let player_name: String?
    let player_number: String?
    let player_type: String?
    let player_age: String?
    let player_match_played: String?
    let player_goals: String?
    let player_yellow_cards: String?
    let player_red_cards: String?
    let player_image: String?
    
}
