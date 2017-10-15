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
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardDidShow(_:)), name:NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        view.backgroundColor = UIColor.LightGreyBackgroundColor()
        setupNavigationTitleProperties()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc open func keyboardWillShow(_ notification: Notification) {
    }
    
    @objc open func keyboardDidShow(_ notification: Notification) {
    }
    
    @objc open func keyboardWillHide(_ notification: Notification) {
    }
    
    @objc open func keyboardDidHide(_ notification: Notification) {
    }
    
    func setupNavigationTitleProperties(withColor color: UIColor = UIColor.white) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
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
        leftBarButton.setImage(UIImage.BackButtonImage, for: UIControlState())
        leftBarButton.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        leftBarButton.frame = CGRect(x: 0, y: 0, width: 35/2, height: 35/2)
        let barButton = UIBarButtonItem(customView: leftBarButton)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func addRightBarButton(withImage image: UIImage, withAction action: Selector) {
        let rightBarButton: UIButton = UIButton()
        rightBarButton.setImage(image, for: UIControlState())
        rightBarButton.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        rightBarButton.frame = CGRect(x: 0, y: 0, width: 35/2, height: 35/2)
        let barButton = UIBarButtonItem(customView: rightBarButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
}
