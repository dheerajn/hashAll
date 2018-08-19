//
//  OnboardingTestViewModel.swift
//  HashMe
//
//  Created by Dheeru on 2/9/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation

class OnboardingTestViewModel: OnboardingViewConfigurable {
    
    var flowDelegate: HashTagFlowDelegate?
    
    init(flowDelegate: HashTagFlowDelegate?) {
        self.flowDelegate = flowDelegate
    }
    
    func setOnboardingValue() {
        
    }
    
    func showPredicitionsView() {
        self.flowDelegate?.showPredictionsView()
    }
    
    var getStartedButtonTitle: String? {
        return "test get started"
    }
}
