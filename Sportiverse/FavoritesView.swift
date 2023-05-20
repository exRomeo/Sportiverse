//
//  ViewController.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 19/05/2023.
//

import UIKit

class FavoritesView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let title = UILabel()
        title.text = "Favorites"
        title.font = UIFont.boldSystemFont(ofSize: 28)
        navigationItem.titleView = title
        
        
        let gestureRec = UISwipeGestureRecognizer(target: self, action:#selector(rightSwipeHandler))
        gestureRec.direction = .right
        self.view.addGestureRecognizer(gestureRec)
    }

    
    
    
    
    
    
    @objc
    func rightSwipeHandler(){
        tabBarController?.selectedIndex = tabBarController!.selectedIndex - 1
    }

}

