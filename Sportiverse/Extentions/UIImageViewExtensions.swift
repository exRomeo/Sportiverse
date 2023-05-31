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
        layer.backgroundColor = UIColor.white.withAlphaComponent(0.05).cgColor
        layer.cornerRadius = (frame.width + frame.height) / 4
        contentMode = .scaleAspectFit
    }
}
