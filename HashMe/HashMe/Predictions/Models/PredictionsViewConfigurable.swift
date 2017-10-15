//
//  HashTagsViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import CoreML

public protocol PredictionsViewConfigurable: class {
    var screenTitle: String? { get }
    var descriptionLabelText: String? { get }
    var maxNumOfKeys: Int { get }
    
    var cameraButtonTitle: String? { get }
    var photoLibraryButtonTitle: String? { get }
    var predictButtonTitle: String? { get }
    
    /// Predicts the image.
    ///
    /// - Parameter ref: Based on the image buffer type. The pixel buffer implements the memory storage for an image buffer.
    func predictImage(ref: CVPixelBuffer)
}
