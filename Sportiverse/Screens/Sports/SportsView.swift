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
    
    
    var viewModel: SportsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SportsViewModel()
        setupPageTitle()
        setupGridView()
        setupSwipeGesture()
    }
    
    func setupPageTitle(){
        let title = UILabel()
        title.text = "Sports"
        title.font = UIFont.boldSystemFont(ofSize: 28)
        navigationItem.titleView = title
    }
    
    
    func setupGridView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func setupSwipeGesture(){
        let gestureRec = UISwipeGestureRecognizer(target: self, action:#selector(leftSwipeHandler))
        gestureRec.direction = .left
        self.view.addGestureRecognizer(gestureRec)
    }
    
    @objc
    func leftSwipeHandler(){
        tabBarController?.selectedIndex +=  1
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
        let itemWidth = view.frame.width / 2 - (layout.minimumInteritemSpacing + 8)
        let itemHeight = view.frame.height / 3
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesScreen = storyboard?.instantiateViewController(withIdentifier: "leaguesScreen") as! LeaguesView
            
        leaguesScreen.instantiateViewModel(sportType: viewModel.sports[indexPath.row].name) 
        navigationController?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(leaguesScreen, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
}

extension SportsView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sports.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportCell
        cell.configureAnimation(with: viewModel.sports[indexPath.row].animName)
        cell.sportTitle.text = viewModel.sports[indexPath.row].name
        return cell
    }
    
}
