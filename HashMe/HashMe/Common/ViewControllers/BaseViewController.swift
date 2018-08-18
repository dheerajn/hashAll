//
//  BaseViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    open var initialLoad: Bool = true
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override open var shouldAutorotate: Bool {
        return true
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationBarTransparent()
        view.backgroundColor = UIColor.LightGreyBackgroundColor()
        setupNavigationTitleProperties()
    }

    func setupNavigationTitleProperties(withColor color: UIColor = UIColor.white) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 20)]
    }
    
    open func hideLeftNavBarButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    open func makeNavigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    open func setStatusBar() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    open func resetStatusBar() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
    }
    
    func addLeftBarButton(withAction action: Selector) {
        let leftBarButton: UIButton = UIButton()
        leftBarButton.setImage(UIImage.BackButtonImage, for: UIControl.State())
        leftBarButton.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        leftBarButton.frame = CGRect(x: 0, y: 0, width: 50/2, height: 50/2)
        let barButton = UIBarButtonItem(customView: leftBarButton)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func addRightBarButton(withImage image: UIImage, withAction action: Selector) {
        let rightBarButton: UIButton = UIButton()
        rightBarButton.setImage(image, for: UIControl.State())
        rightBarButton.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        rightBarButton.frame = CGRect(x: 0, y: 0, width: 50/2, height: 50/2)
        let barButton = UIBarButtonItem(customView: rightBarButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("\(self.description.debugDescription) deinit")
    }
}
