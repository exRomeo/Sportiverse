//
//  LeagueDTO.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 20/05/2023.
//

import Foundation

class LeagueDTO {
    let leaue_key: Int?
    let league_name: String?
    let country_key: Int?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
    let league_year: String?
    
    init(leaue_key: Int?, league_name: String?, country_key: Int?, country_name: String?, league_logo: String?, country_logo: String?, league_year: String?) {
        self.leaue_key = leaue_key
        self.league_name = league_name
        self.country_key = country_key
        self.country_name = country_name
        self.league_logo = league_logo
        self.country_logo = country_logo
        self.league_year = league_year
    }
    
}
