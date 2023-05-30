//
//  ActivityIndicatorExtension.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 30/05/2023.
//

import Foundation
import UIKit
extension UIActivityIndicatorView {
    func addIndicator(to view: UIView){
        color = .blue
        center = CGPoint(x: view.frame.width/2, y: view.frame.height/2) 
        startAnimating()
        view.addSubview(self)
    }
}
