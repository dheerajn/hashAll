//
//  HashTagsViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public protocol HashTagsViewConfigurable: class {
    var screenTitle: String? { get }
    
    //UI
    var cameraButtonTitle: String? { get }
    var photoLibraryButtonTitle: String? { get }
    var predictButtonTitle: String? { get }
}
