//
//  AlertViewPresentable.swift
//  HashMe
//
//  Created by Dheeru on 8/19/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol AlertViewPresentable {
    func displayAlertWithTitle(_ title: String?, message: String?, andActions actions: [CustomAlertAction]?)
}

extension AlertViewPresentable {
    func displayAlertWithTitle(_ title: String?, message: String?, andActions actions: [CustomAlertAction]?) {
        CustomAlertController().displayAlertWithTitle(title,
                                                      message: message,
                                                      preferredStyle: UIAlertController.Style.alert,
                                                      andActions: actions)
    }
}
