//
//  Decoder.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 31/05/2023.
//

import Foundation
import CoreData

class DecoderUtil {
    
    private let decoder: JSONDecoder
    init() {
        self.decoder = JSONDecoder()
    }
    func decodeLeagues(from data: Data, type: String, context: NSManagedObjectContext) -> Result<[League], Error> {
        decoder.userInfo[CodingUserInfoKey.context] = context
        decoder.userInfo[CodingUserInfoKey.sportType] = type
        
        do {
            let response: LeaguesResponse = try decoder.decode(LeaguesResponse.self, from: data)
            guard let result = response.result else {
                return .failure(AllSportsAPIService.APIError.emptyList)
            }
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func decodeEvents(from data: Data) -> Result<[Event], Error> {
        let decoder = JSONDecoder()
        do {
            let response: EventsResponse = try decoder.decode(EventsResponse.self, from: data)
            guard let result = response.result else {
                return .failure(AllSportsAPIService.APIError.emptyList)
            }
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func decodeTeams(from data: Data) -> Result<[Team], Error> {
        let decoder = JSONDecoder()
        do {
            let response: TeamsResponse = try decoder.decode(TeamsResponse.self, from: data)
            guard let result = response.result else {
                return .failure(AllSportsAPIService.APIError.emptyList)
            }
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
