//
//  KeyboardCustomView.swift
//  HashMe
//
//  Created by Dheeru on 2/10/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation
import UIKit

class KeyboardCustomView: CustomView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var keyboardTextField: UITextField!
    
    var addButtonHandler: ((_ keyboardData: String?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Constants.keyboardViewIdentifier, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.keyboardTextField.borderStyle = UITextField.BorderStyle.roundedRect
        self.keyboardTextField.layer.cornerRadius = 10.0
        
        self.addButton.titleLabel?.text = LocalizedString.addButtonTitle
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if self.addButtonHandler != nil {
            self.addButtonHandler!(self.keyboardTextField.text)
        }
    }
}
