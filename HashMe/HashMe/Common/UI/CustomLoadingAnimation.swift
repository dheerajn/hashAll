//
//  CustomLoadingAnimation.swift
//  HashMe
//
//  Created by Dheeru on 9/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

open class CustomLoadingAnimation: UIView {
    
    fileprivate weak var shapeLayer: CAShapeLayer?
    
    fileprivate let squareView = UIView()
    fileprivate let animationDuration = 0.25
    
    open func startLoadingAnimation() {
        squareView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        squareView.alpha = 1
        squareView.backgroundColor = UIColor.LightGreyBackgroundColor()
        self.addSubview(squareView)
        
        startLoadingAnimationMain(fromX: self.center.x - 25, fromY: self.center.y - 50, toX: self.center.x - 25, toY: self.center.y + 50)
        
        let pause = animationDuration
        DispatchQueue.main.asyncAfter(deadline: TimeInterval.convertToDispatchTimeT(pause), execute: {
            self.startLoadingAnimationMain(fromX: self.center.x + 25, fromY: self.center.y - 50, toX: self.center.x + 25, toY: self.center.y + 50)
        })
        
        DispatchQueue.main.asyncAfter(deadline: TimeInterval.convertToDispatchTimeT(pause * 2), execute: {
            self.startLoadingAnimationMain(fromX: self.center.x + 55, fromY: self.center.y - 20, toX: self.center.x - 55, toY: self.center.y - 20)
        })
        
        DispatchQueue.main.asyncAfter(deadline: TimeInterval.convertToDispatchTimeT(pause * 3), execute: {
            self.startLoadingAnimationMain(fromX: self.center.x + 55, fromY: self.center.y + 20, toX: self.center.x - 55, toY: self.center.y + 20)
        })
        
        
    }
    
    fileprivate func startLoadingAnimationMain(fromX: CGFloat, fromY: CGFloat, toX: CGFloat, toY: CGFloat) {
        
        // remove old shape layer if any
        //        self.shapeLayer?.removeFromSuperlayer()
        // create whatever path you want
        let path = UIBezierPath()
        path.move(to: CGPoint(x: fromX, y: fromY))
        path.addLine(to: CGPoint(x: toX, y: toY))
        
        
        // create shape layer for that path
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        squareView.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = animationDuration
        shapeLayer.add(animation, forKey: "MyAnimation")
        
    }
}
