//
//  UIImageViewExtentions.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 30/05/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func makeRounded(){
        layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25).cgColor
        layer.cornerRadius = frame.width/2
        contentMode = .scaleAspectFit
    }
}
