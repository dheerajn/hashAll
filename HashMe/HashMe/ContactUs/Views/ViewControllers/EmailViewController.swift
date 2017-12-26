//
//  EmailViewController.swift
//  HashMe
//
//  Created by Dheeru on 12/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class EmailViewController: BaseViewController, MFMailComposeViewControllerDelegate {
    
    var viewModel: EmailViewConfigurable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        sendEmailButtonTapped()
    }
    
    func sendEmailButtonTapped() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(viewModel?.recipients ?? [""])
        mailComposerVC.setSubject(viewModel?.subject ?? "")
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        dispatchOnMainQueueWith(delay: 1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch (result) {
        case .cancelled:
            print("mail cancelled")
            break
        case .saved:
            print("mail saved")
            break
        case .sent:
            print("mail sent successfully")
            break
        case .failed:
            print("mail failed")
            break
        }
        controller.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
