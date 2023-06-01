//
//  Database.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 23/05/2023.
//

import Foundation
import CoreData
import UIKit

class Database: IDatabase {
    
    static var shared: Database = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return Database(managedContext: delegate.persistentContainer.viewContext)
    }()
    
    private var managedContext: NSManagedObjectContext
    
    private let leagueEntity = "League"
    
    private init(managedContext: NSManagedObjectContext){
        self.managedContext = managedContext
    }
    
    func getAllLeagues(filteredBy sportType: String?, onCompletion: ([League]) -> Void) {
        let fetchRequest = NSFetchRequest<League>(entityName: leagueEntity)
        if let sportType = sportType {
            fetchRequest.predicate = NSPredicate(format: "sportType == %@", sportType)
        }
        do {
            onCompletion(try managedContext.fetch(fetchRequest))
        } catch {
            onCompletion([League]())
        }
    }
    
    func getAllFavorites(onCompletion: ([League]) -> Void) {
        let fetchRequest = NSFetchRequest<League>(entityName: leagueEntity)
        
        fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
        
        do {
            onCompletion(try managedContext.fetch(fetchRequest))
        } catch {
            onCompletion([League]())
        }
    }
    
    func commit(){
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func remove(league: League){
        managedContext.delete(league)
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
