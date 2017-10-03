//
//  OnboardingViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class OnboardingViewController: BaseViewController {
    var flowDelegate: HashTagFlowDelegate?
    
    @IBOutlet weak var getstartedButton: UIButton!
    var viewModel: OnboardingViewConfigurable? {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = OnboardingViewModel()
        self.title = viewModel?.screeTitle ?? "HASH ME ONBOARDING"
        self.getstartedButton.setTitle(viewModel?.buttonTitle ?? "Get Started", for: UIControlState.normal)
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        let customUserDefaults = CustomUserDefault()
        customUserDefaults.setOnboardingWithValue()
        
        self.flowDelegate?.showPredictionsView()
    }
}
