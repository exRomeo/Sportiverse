//
//  League.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 23/05/2023.
//

import Foundation
import CoreData

@objc(League)
public class League: NSManagedObject, Decodable {
        
    public override required init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?){
        super.init(entity: entity, insertInto: context)
    }
    
    
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let contextUserInfoKey = CodingUserInfoKey.context
        let sportTypeUserInfoKey = CodingUserInfoKey.sportType
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
        let type = decoder.userInfo[sportTypeUserInfoKey] as? String else {
            fatalError("Failed to decode Subject!")
            
        }
        
        
        let entity = NSEntityDescription.entity(forEntityName: "League", in: managedObjectContext)
        self.init(entity: entity!, insertInto: managedObjectContext)
        
        league_key = (try? container.decodeIfPresent(Int16.self, forKey: .league_key)) ?? 0
        league_name = try? container.decodeIfPresent(String.self, forKey: .league_name)
        league_logo = try? container.decodeIfPresent(String.self, forKey: .league_logo)
        league_year = try? container.decodeIfPresent(String.self, forKey: .league_year)
        country_key = (try? container.decodeIfPresent(Int16.self, forKey: .country_key)) ?? 0
        country_name = try? container.decodeIfPresent(String.self, forKey: .country_name)
        country_logo = try? container.decodeIfPresent(String.self, forKey: .country_logo)
        sportType = type
        isFavorite = false

        id = Int64("\(league_key)\(country_key)\(league_name)\(league_logo)\(league_year)\(country_logo)\(country_name)\(country_logo)\(sportType)".strHash())
    }
    
    enum CodingKeys: String, CodingKey {
        case league_key
        case league_name
        case league_logo
        case league_year
        case country_key
        case country_name
        case country_logo
    }
       
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
    static let sportType = CodingUserInfoKey(rawValue: "sprotType")!
    
}
extension String {
    func strHash() -> UInt64 {
        var result = UInt64 (5381)
        let buf = [UInt8](self.utf8)
        for b in buf {
            result = 127 * (result & 0x00ffffffffffffff) + UInt64(b)
        }
        return result
    }
}
