//
//  OnboardingSubViewControllerThree.swift
//  HashMe
//
//  Created by Dheeru on 10/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class OnboardingSubViewControllerThree: BaseViewController {

    @IBOutlet weak var step3Label: CustomLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if initialLoad {
            self.step3Label.text = LocalizedString.onboardingStep3Text
            self.step3Label.animateAlpha(duration: 2, delay: 0)
            initialLoad = false
        }
    }
}
