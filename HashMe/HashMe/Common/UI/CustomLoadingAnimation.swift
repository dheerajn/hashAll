//
//  CustomLoadingAnimation.swift
//  HashMe
//
//  Created by Dheeru on 9/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

//    |   |
//  --| - |--
//    |   |
//  --| - |--
//    |   |

open class CustomLoadingAnimation: UIView {
    
    fileprivate weak var shapeLayer1: CAShapeLayer?
    fileprivate weak var shapeLayer2: CAShapeLayer?
    fileprivate weak var shapeLayer3: CAShapeLayer?
    fileprivate weak var shapeLayer4: CAShapeLayer?
    
    fileprivate let squareView = UIView()
    fileprivate let animationDuration = 0.25
    
    /// This helps you not drawing the base lines for the animation more than once.
    fileprivate var initialLoad: Bool = true
    
    open func startLoadingAnimation() {
        squareView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        squareView.alpha = 1
        self.addSubview(squareView)
        let _ = squareView.addLightBlurEffect()
        drawBaseLinesForAnimation()
        
        self.startLoadingAnimation(fromX: self.center.x - 25, fromY: self.center.y - 50, toX: self.center.x - 25, toY: self.center.y + 50)
        
        let pause = animationDuration
        dispatchOnMainQueueWith(delay: pause) {
            self.startLoadingAnimation(fromX: self.center.x + 25, fromY: self.center.y - 50, toX: self.center.x + 25, toY: self.center.y + 50)
        }
        dispatchOnMainQueueWith(delay: pause * 2) {
            self.startLoadingAnimation(fromX: self.center.x + 55, fromY: self.center.y - 20, toX: self.center.x - 55, toY: self.center.y - 20)
        }
        dispatchOnMainQueueWith(delay: pause * 3) {
            self.startLoadingAnimation(fromX: self.center.x + 55, fromY: self.center.y + 20, toX: self.center.x - 55, toY: self.center.y + 20)
        }
        dispatchOnMainQueueWith(delay: pause * 4) {
            UIView.animate(withDuration: 0.5, animations: {
                self.shapeLayer1?.removeFromSuperlayer()
                self.shapeLayer2?.removeFromSuperlayer()
                self.shapeLayer3?.removeFromSuperlayer()
                self.shapeLayer4?.removeFromSuperlayer()
            }, completion: { (success) in
                self.startLoadingAnimation()
            })
        }
    }
    
    fileprivate func startLoadingAnimation(fromX: CGFloat, fromY: CGFloat, toX: CGFloat, toY: CGFloat, animation: Bool = true, strokeColor: UIColor = UIColor.white) {
        
        // remove old shape layer if any
        //        self.shapeLayer?.removeFromSuperlayer()
        // create whatever path you want
        let path = UIBezierPath()
        path.move(to: CGPoint(x: fromX, y: fromY))
        path.addLine(to: CGPoint(x: toX, y: toY))
        
        
        // create shape layer for that path
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        squareView.layer.addSublayer(shapeLayer)
        
        if animation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = animationDuration
            shapeLayer.add(animation, forKey: "MyAnimation")
            
            assignShapeLayer(shapeLayer: shapeLayer)
        }
    }
    
    /// This Method helps in drawing (only once) the base line for the animation.
    fileprivate func drawBaseLinesForAnimation() {
        if initialLoad {
            initialLoad = false
            let linesBaseColor = UIColor.darkGray.withAlphaComponent(0.7)
            self.startLoadingAnimation(fromX: self.center.x - 25, fromY: self.center.y - 50, toX: self.center.x - 25, toY: self.center.y + 50, animation: false, strokeColor: linesBaseColor)
            self.startLoadingAnimation(fromX: self.center.x + 25, fromY: self.center.y - 50, toX: self.center.x + 25, toY: self.center.y + 50, animation: false, strokeColor: linesBaseColor)
            self.startLoadingAnimation(fromX: self.center.x + 55, fromY: self.center.y - 20, toX: self.center.x - 55, toY: self.center.y - 20, animation: false, strokeColor: linesBaseColor)
            self.startLoadingAnimation(fromX: self.center.x + 55, fromY: self.center.y + 20, toX: self.center.x - 55, toY: self.center.y + 20, animation: false, strokeColor: linesBaseColor)
        }
    }
    
    fileprivate func assignShapeLayer(shapeLayer: CAShapeLayer) {
        if self.shapeLayer1 == nil {
            self.shapeLayer1 = shapeLayer
        } else if self.shapeLayer2 == nil {
            self.shapeLayer2 = shapeLayer
        } else if self.shapeLayer3 == nil {
            self.shapeLayer3 = shapeLayer
        } else if self.shapeLayer4 == nil {
            self.shapeLayer4 = shapeLayer
        }
    }
}
