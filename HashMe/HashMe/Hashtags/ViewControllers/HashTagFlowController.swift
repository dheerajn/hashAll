//
//  HashTagFlowController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol HashTagFlowDelegate: NavigationControllable {}

class HashTagFlowController: HashTagFlowDelegate {
    
    var navigationController: UINavigationController?
    var initialViewController: UIViewController?
    
    init(initialViewController: UIViewController) {
        self.initialViewController = initialViewController
        showHashTagView()
    }
    
    func showHashTagView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let hashTagVc = storyboard.instantiateViewController(withIdentifier: "HashTagsViewController") as? HashTagsViewController
        hashTagVc?.viewModel = HashTagsViewModel()
        
        self.navigationController = UINavigationController(rootViewController: hashTagVc!)
        self.initialViewController?.present(self.navigationController!, animated: true, completion: nil)
    }
}
