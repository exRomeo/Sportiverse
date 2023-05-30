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
        showMessage(error.localizedDescription, with: .systemRed, on: view)
    }
    
    func show(errorMessage :String, on view: UIView){
        showMessage(errorMessage, with: .systemRed, on: view)
    }
    
    func showMessage(_ message:String, with color: UIColor, on view:UIView){
        text = message
        textAlignment = .center
        textColor = color
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
