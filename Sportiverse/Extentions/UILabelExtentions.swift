//
//  UILabelExtentions.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 30/05/2023.
//

import Foundation
import UIKit

extension UILabel {
    func show(errorMessage error:Error, on view: UIView){
        text = error.localizedDescription
        textAlignment = .center
        textColor = .systemRed
        font = UIFont.boldSystemFont(ofSize: 28)
        view.addSubview(self)
        numberOfLines = 2
        frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    func show(errorMessage :String, on view: UIView){
        text = errorMessage
        textAlignment = .center
        textColor = .systemRed
        font = UIFont.boldSystemFont(ofSize: 28)
        view.addSubview(self)
        numberOfLines = 2
        frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    func make(title:String) -> UILabel {
        text = title
        font = UIFont.boldSystemFont(ofSize: 28)
        return self
    }
}
