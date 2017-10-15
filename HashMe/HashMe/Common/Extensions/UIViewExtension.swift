//
//  UIViewExtension.swift
//  HashMe
//
//  Created by Dheeru on 10/9/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addLightBlurEffect() -> UIView {
        return addLightBlurEffectView(false)
    }
    
    func addLightBlurEffectView(_ animated: Bool) -> UIView {
        return addBlurEffectView(withBlurStyle: .light, aboveSubview: nil, animated: animated)
    }
    
    func addMediumBlurEffect() -> UIView {
        return addMediumBlurEffectView(false)
    }
    
    func addMediumBlurEffectView(_ animated: Bool) -> UIView {
        return addBlurEffectView(withBlurStyle: .light, aboveSubview: nil, andDarkAlpha: 0.4, animated: animated)
    }
    
    func addDarkBlurEffect() -> UIView {
        return addDarkBlurEffectView(false)
    }
    
    func addDarkBlurEffectView(_ animated: Bool) -> UIView {
        return addBlurEffectView(withBlurStyle: .dark, aboveSubview: nil, animated: animated)
    }
    
    func addBlurEffectView(withBlurStyle blurStyle: UIBlurEffectStyle, aboveSubview subview: UIView?) -> UIView {
        return addBlurEffectView(withBlurStyle: blurStyle, aboveSubview: subview, andDarkAlpha: 0.0, animated: false)
    }
    
    func addBlurEffectView(withBlurStyle blurStyle: UIBlurEffectStyle, aboveSubview subview: UIView?, animated: Bool) -> UIView {
        return addBlurEffectView(withBlurStyle: blurStyle, aboveSubview: subview, andDarkAlpha: 0.0, animated: animated)
    }
    
    func addBlurEffectView(withBlurStyle blurStyle: UIBlurEffectStyle, aboveSubview subview: UIView?, andDarkAlpha darkAlpha: CGFloat, animated: Bool) -> UIView {
        // For the blur effect
        removeBlur()
        backgroundColor = UIColor.clear
        let blurContainerView = UIView()
        blurContainerView.frame = bounds
        blurContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurContainerView.addSubview(blurEffectView)
        if darkAlpha > 0.0 {
            let darkenView = UIView()
            darkenView.frame = blurEffectView.frame
            darkenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            darkenView.backgroundColor = UIColor.black
            darkenView.alpha = darkAlpha
            blurContainerView.addSubview(darkenView)
        }
        if (subview != nil) {
            insertSubview(blurContainerView, aboveSubview: subview!)
        } else {
            insertSubview(blurContainerView, at: 0)
        }
        if animated {
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                blurEffectView.effect = blurEffect
            })
        } else {
            blurEffectView.effect = blurEffect
        }
        return blurContainerView
    }
    
    func removeBlur() {
        removeBlur(false)
    }
    
    func removeBlur(_ animated: Bool) {
        for subview: UIView in subviews {
            for view: UIView in subview.subviews {
                if (view is UIVisualEffectView) {
                    if animated {
                        UIView.animate(withDuration: 0.5, animations: {() -> Void in
                            (view as? UIVisualEffectView)?.effect = nil
                        }, completion: {(_ finished: Bool) -> Void in
                            subview.removeFromSuperview()
                        })
                    } else {
                        subview.removeFromSuperview()
                    }
                    return
                }
            }
        }
    }
    
    func setupMediumBluredViewOnImage(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleToFill
        imageView.frame = UIScreen.main.bounds
        self.insertSubview(imageView, at: 0)
        
        _ = imageView.addMediumBlurEffect()
    }
    
    func setupLightBluredViewOnImage(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleToFill
        imageView.frame = UIScreen.main.bounds
        self.insertSubview(imageView, at: 0)
        
        _ = imageView.addLightBlurEffect()
    }
    
    func setupDarkBluredViewOnImage(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleToFill
        imageView.frame = UIScreen.main.bounds
        self.insertSubview(imageView, at: 0)
        
        _ = imageView.addDarkBlurEffect()
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
