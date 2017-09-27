//
//  CustomLabel.swift
//  HashMe
//
//  Created by Dheeru on 9/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

@IBDesignable class CustomLabel: UILabel {
    
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
            self.minimumScaleFactor = minimumScalingFactor
            self.adjustsFontSizeToFitWidth = true
        }
    }
}
