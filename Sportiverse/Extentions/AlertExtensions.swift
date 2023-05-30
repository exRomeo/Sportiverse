//
//  AlertExtensions.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 31/05/2023.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func showNoInternetDialog(from viewController: UIViewController) {
        let alertController = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your internet connection and try again.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
