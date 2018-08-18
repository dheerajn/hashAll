//
//  UILabelExtension.swift
//  HashMe
//
//  Created by Dheeru on 10/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

//https://github.com/Yalantis/EatFit/blob/master/EatFit/Extensions/UILabel%2BAnimation.swift
extension UILabel {
    
    /// This method helps you animating by adding character by character.
    ///
    /// - Parameter duration: Time to show this animation.
    func animateAdding(_ duration: Double) {
        if let text = text {
            iterateAdding(text as NSString, index: 0, delay: duration / Double(text.count))
        }
    }
    
    fileprivate func iterateAdding(_ text: NSString, index: Int, delay: Double) {
        let substring = text.substring(to: index)
        self.text = substring
        
        if text as String != substring {
            let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.iterateAdding(text, index: index + 1, delay: delay)
            }
        }
    }
    
    /// This method helps you animating the alpha value of each character by character.
    ///
    /// - Parameters:
    ///   - duration: Time to show this animation.
    ///   - delay: This animation will start after the delay given.
    func animateAlpha(duration: Double, delay: Double) {
        if let text = text {
            let originalFontColor = self.textColor
            
            textColor = UIColor.clear
            
            dispatchOnMainQueueWith(delay: delay, closure: {
                self.iterateAlpha(text as NSString, index: 0, delay: duration / Double(text.count), font: self.font, color: originalFontColor!)
            })
        }
    }
    
    fileprivate func iterateAlpha(_ text: NSString, index: Int, delay: Double, font: UIFont, color: UIColor) {
        let substringToShow = text.substring(to: index);
        let substringToHide = text.substring(from: index);
        
        let showAttrs = [NSAttributedString.Key.font: font,
                         NSAttributedString.Key.foregroundColor: color]
        let showString = NSAttributedString(string: substringToShow, attributes: showAttrs)
        
        let hideAttrs = [NSAttributedString.Key.font: font,
                         NSAttributedString.Key.foregroundColor: UIColor.clear]
        
        let hideString = NSAttributedString(string: substringToHide, attributes: hideAttrs)
        
        let result = NSMutableAttributedString()
        result.append(showString)
        result.append(hideString)
        
        self.attributedText = result
        
        if substringToHide.count != 0 {
            let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                self.iterateAlpha(text, index: index + 1, delay: delay, font: font, color: color)
            }
        }
    }
}
