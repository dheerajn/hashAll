//
//  OnboardingSubViewControllerOne.swift
//  HashMe
//
//  Created by Dheeru on 10/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class OnboardingSubViewControllerOne: UIViewController {

    @IBOutlet weak var screenShot1: CustomImageView!
    @IBOutlet weak var step1Label: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.step1Label.text = LocalizedString.onboardingStep1Text
        self.step1Label.animateAlpha(duration: 2, delay: 0)
    }
}
