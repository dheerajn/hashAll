//
//  LoadingScreenPresentable.swift
//  HashMe
//
//  Created by Dheeru on 9/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol LoadingScreenPresentable: class {
    func startLoadingAnimation()
    func removeLoadingAnimationFromSuperView()
}

// This helps presenting the loading screen for a view controler
extension LoadingScreenPresentable where Self: UIViewController {
    func startLoadingAnimation() {
        let loadingView = CustomLoadingAnimation()
        loadingView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        loadingView.alpha = 1
        loadingView.tag = Constants.Tags.loadingViewTag
        loadingView.startLoadingAnimation()
        self.view.addSubview(loadingView)
    }
    
    func removeLoadingAnimationFromSuperView() {
        UIView.animate(withDuration: 0.5, animations: {
            let loadingView = self.view.viewWithTag(Constants.Tags.loadingViewTag)
            loadingView?.alpha = 0.0
        }) { (success) in
            self.view.viewWithTag(Constants.Tags.loadingViewTag)?.removeFromSuperview()
        }
    }
}

// This helps presenting the loading screen for a view
public extension LoadingScreenPresentable where Self: UIView {
    
    func startLoadingAnimation() {
        let loadingView = CustomLoadingAnimation()
        loadingView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        loadingView.alpha = 1
        loadingView.tag = Constants.Tags.loadingViewTag
        loadingView.startLoadingAnimation()
        self.superview?.addSubview(loadingView)
    }
    
    func removeLoadingAnimationFromSuperView() {
        UIView.animate(withDuration: 0.5, animations: {
            let loadingView = self.viewWithTag(Constants.Tags.loadingViewTag)
            loadingView?.alpha = 0.0
        }) { (success) in
            self.superview?.viewWithTag(Constants.Tags.loadingViewTag)?.removeFromSuperview()
        }
    }
}
