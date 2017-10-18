//
//  SocialMediaCustomView.swift
//  HashMe
//
//  Created by Dheeraj Neelam on 10/18/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class SocialMediaCustomView: CustomView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    var instagramButtonCustomHander: (() -> Void)?
    var dismissButtonCustomHandler: (() -> Void)?
    var moreButtonCustomHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SocialMediaView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        if self.dismissButtonCustomHandler != nil {
            self.dismissButtonCustomHandler!()
        }
    }
    @IBAction func instagramButtonTapped(_ sender: Any) {
        if self.instagramButtonCustomHander != nil {
            self.instagramButtonCustomHander!()
        }
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        if self.moreButtonCustomHandler != nil {
            self.moreButtonCustomHandler!()
        }
    }
    
}
