//
//  CustomButton.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var minimumScalingFactor: CGFloat = 0.5 {
        didSet {
            self.titleLabel?.minimumScaleFactor = minimumScalingFactor
            self.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
}
