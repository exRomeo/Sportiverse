//
//  SportsView.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 19/05/2023.
//

import UIKit
import Lottie

private let reuseIdentifier = "sportCell"

class SportsView: UICollectionViewController {
    
    let sports = [
        Sport(name: "Football", animName: "football_anim", url: ""),
        Sport(name: "Basketball", animName: "basketball_anim", url: ""),
        Sport(name: "Tennis", animName: "tennis_anim", url: ""),
        Sport(name: "Cricket", animName: "cricket_anim", url: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = UILabel()
        title.text = "Sports"
        title.font = UIFont.boldSystemFont(ofSize: 28)
        navigationItem.titleView = title
            
        let gestureRec = UISwipeGestureRecognizer(target: self, action:#selector(leftSwipeHandler))
        gestureRec.direction = .left
        self.view.addGestureRecognizer(gestureRec)
        
        setupGridView()
        
    }
    
    func setupGridView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    @objc
    func leftSwipeHandler(){
        tabBarController?.selectedIndex =  tabBarController!.selectedIndex + 1
    }

}

extension SportsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
 
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemWidth = collectionView.frame.width / 2 - (layout.minimumInteritemSpacing + 8)
        let itemHeight = navigationController!.view.frame.height / 3
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked a cell \(sports[indexPath.row].name)")
        let leaguesScreen = storyboard?.instantiateViewController(withIdentifier: "leaguesScreen") as! LeaguesView

        leaguesScreen.sportName = sports[indexPath.row].name
        navigationController?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(leaguesScreen, animated: true)

    }
}

extension SportsView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportCell
        cell.configureAnimation(with: sports[indexPath.row].animName)
        cell.sportTitle.text = sports[indexPath.row].name
        return cell
    }
    
}
