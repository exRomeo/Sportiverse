//
//  LeaguesResponse.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 22/05/2023.
//

import Foundation

class LeaguesResponse: Decodable {
    let success: Int?
    let result: [League]?
    
    init(success: Int?, result: [League]?) {
        self.success = success
        self.result = result
    }
}
