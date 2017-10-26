//
//  OnboardingSubViewControllerTwo.swift
//  HashMe
//
//  Created by Dheeraj Neelam on 10/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class OnboardingSubViewControllerTwo: UIViewController {

    @IBOutlet weak var step2Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.step2Label.text = LocalizedString.onboardingStep2Text
        self.step2Label.animateAlpha(duration: 2, delay: 0)
    }
}
