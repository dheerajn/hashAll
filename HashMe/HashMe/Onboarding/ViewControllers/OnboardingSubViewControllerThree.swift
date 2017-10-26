//
//  OnboardingSubViewControllerThree.swift
//  HashMe
//
//  Created by Dheeraj Neelam on 10/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class OnboardingSubViewControllerThree: UIViewController {

    @IBOutlet weak var step3Label: CustomLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.step3Label.text = LocalizedString.onboardingStep3Text
        self.step3Label.animateAlpha(duration: 2, delay: 0)
    }
}
