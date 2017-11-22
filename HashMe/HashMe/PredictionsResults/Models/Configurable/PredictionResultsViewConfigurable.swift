//
//  PredictionResultsViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol PredictionResultsViewConfigurable: class {
    
    var flowDelegate: HashTagFlowDelegate? { get set }
    var originalPredictions: [String]? { get }
    var predictionImage: UIImage? { get }
    var updatedPredicitons: [String]? { get set } //this will append and remove a string, so "set" is required
    var copyButtonTitle: String? { get }
    var selectAllButtonTitle: String? { get }
    var copiedLabelTitle: String? { get }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func selectAllButtonTapped()
    func updatePredictionsArray(forHashTag tag: String)
    func copyHashTagsToPasteboard()
    func launchShareActivity()
}
