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
        self.title = viewModel?.screeTitle ?? "HASH ME"
        self.getstartedButton.setTitle(viewModel?.buttonTitle ?? "Get Started", for: UIControlState.normal)
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        UserDefaults.standard.setValue("Done", forKey: Constants.onboaringIdentifier)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let hashTagVc = storyboard.instantiateViewController(withIdentifier: "HashTagsViewController") as? HashTagsViewController
//        hashTagVc?.viewModel = HashTagsViewModel()
//        present(hashTagVc!, animated: true, completion: nil)
        self.flowDelegate = HashTagFlowController(initialViewController: self)
    }
}
