//
//  PredictionsViewModel.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class PredictionsViewModel: PredictionsViewConfigurable {
    
    var screenTitle: String? {
        return "Hash Me title"
    }
    
    var cameraButtonTitle: String? {
        return "CAMERA"
    }
    var photoLibraryButtonTitle: String? {
        return "PHOTO LIBRARY"
    }
    var predictButtonTitle: String? {
        return "GENERATE HASHTAGS"
    }
    
    var maxNumOfKeys: Int? {
        return 7
    }
}
