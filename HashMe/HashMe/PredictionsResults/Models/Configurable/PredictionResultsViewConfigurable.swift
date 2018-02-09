//
//  PredictionResultsViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol PredictionResultsViewConfigurable: ViewModelConfigurable {
    
    /// Delegate that controls the views
    var flowDelegate: HashTagFlowDelegate? { get set }
    
    /// These are the original predictions that comes to the results vc after some manipulation in the other class
    var originalPredictions: [String]? { get set }
    
    /// Image that was selected by the user so we can pass it to different social networking apps
    var predictionImage: UIImage? { get }
    
    /// These prediction are set to empty by default, but gets updated upon selecting the tags and deselecting the tags
    var updatedPredicitons: [String]? { get set } //this will append and remove a string, so "set" is required
    
    /// Title for copy button
    var copyButtonTitle: String? { get }
    
    /// Title for select all button
    var selectAllButtonTitle: String? { get }
    
    /// Title for copied label
    var copiedLabelTitle: String? { get }
    
    
    /// NumberOfItemsInSection to set for the collection view
    ///
    /// - Parameters:
    ///   - collectionView: Collection view that is looking for this method
    ///   - section: Section for which number of items needed
    /// - Returns: returns an integer value
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    /// This method gets called when select all button is tapped
    func selectAllButtonTapped()
    
    /// This method gets called when deselect all button is tapped
    func deselectAllButtonTapped()
    
    /// This method updates the array by appending to it if the element is not found
    ///
    /// - Parameter tag: Tag that is selected
    func updatePredictionsArray(forHashTag tag: String)
    
    /// This method gets called when user taps on copy button
    func copyHashTagsToPasteboard()
    
    /// This method launches the activity vc when more button is called
    func launchShareActivity(withFrame: CGRect)
}
