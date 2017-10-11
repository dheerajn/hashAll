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
    
    open func hideLeftNavBarButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    open func makeNavigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func addLeftBarButton() {
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage.BackButtonImage, for: UIControlState())
        btnLeftMenu.addTarget(self, action: #selector(BaseViewController.popViewController), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func popViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
