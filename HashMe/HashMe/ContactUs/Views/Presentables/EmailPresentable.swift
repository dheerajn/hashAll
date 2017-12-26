//
//  EmailPresentable.swift
//  HashMe
//
//  Created by Dheeru on 12/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public protocol EmailPresentable: class {
    func showEmailView()
}

public extension EmailPresentable where Self: HashTagFlowController {
    func showEmailView() {
        let emailViewController = EmailViewController()
        let emailViewModel = EmailViewModel()
        emailViewModel.flowDelegate = self
        emailViewController.viewModel = emailViewModel
        
        emailViewController.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(emailViewController, animated: true, completion: nil)
    }
}
