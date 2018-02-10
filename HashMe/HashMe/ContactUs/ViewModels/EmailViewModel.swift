//
//  EmailViewModel.swift
//  HashMe
//
//  Created by Dheeru on 12/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

class EmailViewModel: EmailViewConfigurable {
    
    weak var flowDelegate: HashTagFlowDelegate?
    
    var recipients: [String]? {
        return [self.contactUsEmailId() ?? Constants.ContactUs.recipient]
    }
    
    var subject: String? {
        return self.contactUsEmailSubject() ?? Constants.ContactUs.subject
    }
}
