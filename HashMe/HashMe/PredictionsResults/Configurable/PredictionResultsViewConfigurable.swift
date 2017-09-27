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
    var predictions: [String]? { get }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
}
