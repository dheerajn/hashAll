//
//  StringExtension.swift
//  HashMe
//
//  Created by Dheeru on 10/19/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    //Ex: "this is string".camelcaseStringLowerCase = "thisIsString"
    var camelCaseStringLowerCase: String {
        if self.isEmpty || self == " " { return "" }
        var source = self
        if source.characters.contains(" ") {
            source = source.lowercased()
            var cammel = source.capitalized.replacingOccurrences(of: " ", with: "")
            let firstCharacter = cammel.remove(at: cammel.startIndex).description.lowercased()
            return "\(firstCharacter)\(cammel)"
        } else {
            // let first = source.substring(to: source.index(startIndex, offsetBy: 1)). This is deprecated so following works fine
            let first = String(source.lowercased()[..<source.index(startIndex, offsetBy: 1)])
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
    
    var camelCaseStringUpperCase: String {
        let source = self
        if source.characters.contains(" ") {
            let first = String(source.lowercased()[..<source.index(startIndex, offsetBy: 1)])
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = String(source[..<source.index(startIndex, offsetBy: 1)])
            let cammel = source.capitalized.replacingOccurrences(of: " ", with: "")
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
}
