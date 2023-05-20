//
//  Sport.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 20/05/2023.
//

import Foundation

class Sport {
    
    let name: String
    let animName:String
    let url: URL?
    
    init(name: String, animName: String, url: String) {
        self.name = name
        self.animName = animName
        self.url = URL(string: url)
    }
}
