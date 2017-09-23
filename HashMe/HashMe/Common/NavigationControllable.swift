//
//  NavigationControllable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol NavigationControllable: class {
    var navigationController: UINavigationController? { get set }
}
