//
//  LeagueDetails.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 25/05/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class LeagueDetails: UIViewController {
    
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var centerCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


extension LeagueDetails: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in each collection view
        switch collectionView{
            
        case topCollectionView:
            return 3
            
        case centerCollectionView:
            return 2
            
        case bottomCollectionView:
            return 5
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue and configure your custom collection view cells here
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        //        as! CustomCell
        // Configure the cell
        switch collectionView{
        
        case topCollectionView:
            cell.backgroundColor = UIColor.red
        
        case centerCollectionView:
            cell.backgroundColor = UIColor.green
        
        case bottomCollectionView:
            cell.backgroundColor = UIColor.purple
        
        default:
            cell.backgroundColor = UIColor.black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            
        case topCollectionView, bottomCollectionView :
            // Return the item size for the top and bottom collection views (horizontal scrolling)
            let itemWidth = collectionView.bounds.width / 3
            return CGSize(width: itemWidth, height: itemWidth)
            
        case centerCollectionView:
            // Return the item size for the middle collection view (vertical scrolling)
            let itemWidth = collectionView.bounds.width
            return CGSize(width: itemWidth, height: 100)
            
        default:
            return CGSize()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
            
        case topCollectionView:
            // Adjust the inset for the top collection view (horizontal scrolling)
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
       
            case centerCollectionView:
            // Adjust the inset for the middle collection view (vertical scrolling)
            return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        case bottomCollectionView:
            // Adjust the inset for the bottom collection view (horizontal scrolling)
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        default:
            return UIEdgeInsets()
        }
    }
}
