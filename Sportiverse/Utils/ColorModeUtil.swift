//
//  ColorModeUtil.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 01/06/2023.
//

import Foundation
import UIKit

class ColorModeUtil {
    static let shared = ColorModeUtil()
    var currentMode: UIUserInterfaceStyle = .unspecified
    private init(){
    }
    
    
    func toggleColorMode() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let mode: UIUserInterfaceStyle = (currentMode == .dark) ? .light : .dark
        windowScene.windows.forEach {
            $0.overrideUserInterfaceStyle = mode
            currentMode = mode
        }
    }
    
    func setColorMode(_ style: UIUserInterfaceStyle) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        windowScene.windows.forEach { $0.overrideUserInterfaceStyle = style }
    }
}
