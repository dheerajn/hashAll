//
//  DeviceIdiom.swift
//  HashMe
//
//  Created by Dheeru on 1/5/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol DeviceIdiom {
    var isDeviceIpad: Bool { get }
    var isDeviceIphone: Bool { get }
}

public extension DeviceIdiom where Self: HashTagFlowController {
    
    var isDeviceIpad: Bool {
        return self.navigationController?.visibleViewController?.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    var isDeviceIphone: Bool {
        return self.navigationController?.visibleViewController?.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
}

extension UIViewController: DeviceIdiom {
    
    public var isDeviceIpad: Bool {
        return self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    public var isDeviceIphone: Bool {
        return self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
}
