//
//  UIColor+Extension.swift
//  Meli
//
//  Created by Cristian Tellez on 2/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    /**
    Extensão para utilizar cores RGB com String
    
    - Parameter subView: view a ser adicionada sobre a parentView.
    
    */
    convenience init(argb rgb:String){
        var cString:String = rgb.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            NSLog("Invalid RGB Color: %@", rgb)
            self.init(red:0.93, green:0.94, blue:0.95, alpha:1.0)
        }else{
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
        }
    }
    
    
    class var corParao : UIColor {
        get {
            return #colorLiteral(red: 1, green: 0.9034662247, blue: 0, alpha: 1)
            

        }
    }
}
