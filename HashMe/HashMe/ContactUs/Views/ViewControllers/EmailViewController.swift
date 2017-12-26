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
//        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        print("can not send email")
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
