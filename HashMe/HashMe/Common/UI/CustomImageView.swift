//
//  CustomImageView.swift
//  HashMe
//
//  Created by Dheeru on 10/15/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomImageView: UIImageView {
    
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
}
