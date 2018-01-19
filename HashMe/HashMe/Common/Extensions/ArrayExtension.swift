//
//  ArrayExtension.swift
//  HashMe
//
//  Created by Dheeru on 1/19/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation

public extension Array {
    
    // this is a safe way to get an index without the risk of segfaulting, if there is any ambiguity with your dataset
    // be safe and catch nil insted of risking a crash. Basically this will bypass if there is no element in the array for a particular index.
    //    Ex: if let random = randomArray[safe: row] { } //row can be any number
    
    public subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
