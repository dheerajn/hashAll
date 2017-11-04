//
//  UIColorExtension.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    public var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)  // The resulting Core Image color, or nil
    }
}

public extension UIColor {
    public convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
    }
    
    public convenience init(r: Int, g: Int, b: Int, a: Int) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
    }
    
    public convenience init(color: UIColor?, alpha: CGFloat) {
        
        if let ciColor = color?.coreImageColor {
            let finalAlphaModifier = ciColor.alpha * alpha
            self.init(
                red: min(ciColor.red + (ciColor.red * finalAlphaModifier), 255),
                green: min(ciColor.green + (ciColor.green * finalAlphaModifier), 255),
                blue: min(ciColor.blue + (ciColor.blue * finalAlphaModifier), 255),
                alpha: 1.0)
        } else {
            //"failed to convert \(color) to a ci color, defaulting to white
            self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

public extension UIColor {
    public static func LightGreyBackgroundColor() -> UIColor {
        return UIColor(r: 247, g: 248, b: 249)
    }
    
    public static func PredictionsCellSelectedColor() -> UIColor {
        return UIColor.yellow.withAlphaComponent(0.9)
    }
    
    public static func PredictionsCellDeselectedColor() -> UIColor {
        return UIColor.darkGray.withAlphaComponent(0.75)
    }
}

