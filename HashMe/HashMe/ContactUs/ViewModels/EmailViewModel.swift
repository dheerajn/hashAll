//
//  EmailViewModel.swift
//  HashMe
//
//  Created by Dheeru on 12/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

class EmailViewModel: EmailViewConfigurable {
    
    var flowDelegate: HashTagFlowDelegate?
    
    var recipients: [String]? {
        return [Constants.ContactUs.recipient]
    }
    
    var subject: String? {
        return Constants.ContactUs.subject
    }
}
