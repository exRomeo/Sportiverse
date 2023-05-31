//
//  DatabaseProtocol.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 31/05/2023.
//

import Foundation

protocol IDatabase {
    
    func getAllLeagues(filteredBy sportType: String?, onCompletion: ([League]) -> Void)
    
    func getAllFavorites(onCompletion: ([League]) -> Void)
    
    func commit()
    
    func remove(league: League)
}
