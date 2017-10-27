//
//  OnboardingSubViewControllerTwo.swift
//  HashMe
//
//  Created by Dheeru on 10/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class OnboardingSubViewControllerTwo: BaseViewController {

    @IBOutlet weak var step2Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if initialLoad {
            self.step2Label.text = LocalizedString.onboardingStep2Text
            self.step2Label.animateAlpha(duration: 2, delay: 0)
            initialLoad = false
        }
    }
}
