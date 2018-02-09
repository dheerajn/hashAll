//
//  PredictionsViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit
import CoreML

public protocol PredictionsViewConfigurable: ViewModelConfigurable {
    
    /// This delegate is responsible for communicating with view controler
    weak var delegate: PredictionsViewDelegate? { get set }
    
    /// Title for view controller.
    var screenTitle: String? { get }
    
    /// Text for the label content.
    var descriptionLabelText: String? { get }
    
    /// This helps in showing the number of top elements to be taken from the response.
    var maxNumOfKeys: Int { get }
    
    /// Title for camera button.
    var cameraButtonTitle: String? { get }
    
    /// Title for photo library button
    var photoLibraryButtonTitle: String? { get }
    
    /// Predicts the image.
    ///
    /// - Parameter ref: Based on the image buffer type. The pixel buffer implements the memory storage for an image buffer.
    func predictImage(ref: CVPixelBuffer, predictionImage: UIImage)
    
    
    /// Lets user to email about the application.
    func handleEmailAction()
    
    /// This method gets called when user tap on feedback button
    func getAppStoreAppId() -> String
}

public protocol PredictionsViewDelegate: class {
    
    /// This method will help the view controller to remove the image.
    func removePredictionImage()
}
