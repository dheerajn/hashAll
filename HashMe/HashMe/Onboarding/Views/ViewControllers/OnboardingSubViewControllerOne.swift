//
//  OnboardingSubViewControllerOne.swift
//  HashMe
//
//  Created by Dheeru on 10/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class OnboardingSubViewControllerOne: BaseViewController {

    @IBOutlet weak var step1Label: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if initialLoad {
            self.step1Label.text = LocalizedString.onboardingStep1Text
            self.step1Label.animateAlpha(duration: OnboardingAnimationDuration.tutorialLabelAnimation.rawValue, delay: 0)
            initialLoad = false
        }
    }
    
    deinit {
        print("\(self.description.debugDescription) deinit")
    }
}
