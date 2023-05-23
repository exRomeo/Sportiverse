//
//  League.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 23/05/2023.
//

import Foundation

class League: Codable {
    let league_key: Int?
    let league_name: String?
    let league_logo: String?
    let league_year: String?
    let country_key: Int?
    let country_name: String?
    let country_logo: String?
    var isFavorite: Bool?
    
    init(league_key: Int?, league_name: String?, league_logo: String?, league_year: String?, country_key: Int?, country_name: String?, country_logo: String?) {
        self.league_key = league_key
        self.league_name = league_name
        self.league_logo = league_logo
        self.league_year = league_year
        self.country_key = country_key
        self.country_name = country_name
        self.country_logo = country_logo
        self.isFavorite = false
    }
}
