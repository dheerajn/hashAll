//
//  InstagramActivity.swift
//  HashMe
//
//  Created by Dheeraj Neelam on 10/18/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

class InstagramActivity: UIActivity {
    
    func activityType() -> String {
        return NSStringFromClass(InstagramActivity.self)
    }
    
    override var activityImage: UIImage? {
        return UIImage.InstagramIcon
    }
    
    override var activityTitle: String? {
        return "Instagram"
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        
    }
    
    override func perform() {
        
    }
}
