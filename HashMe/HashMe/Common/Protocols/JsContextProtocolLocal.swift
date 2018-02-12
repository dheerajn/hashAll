//
//  JsContextProtocolLocal.swift
//  HashMe
//
//  Created by Dheeru on 2/9/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation
import JavaScriptCore

public protocol JsContextProtocolLocal: class {
    
    /// This is JsContext which works with the local file
    var context: JSContext? { get }
}

extension JsContextProtocolLocal {
    public var context: JSContext? {
        let context = JSContext()
        guard let commonJSPath = Bundle.main.path(forResource: Constants.RuleEngine.hashMeRuleEngineFileName, ofType: "js") else {
            print("Unable to read resource files since the path is not found")
            return nil
        }
        do {
            let common = try String(contentsOfFile: commonJSPath, encoding: String.Encoding.utf8)
            _ = context?.evaluateScript(common)
        } catch (let error) {
            print("Error while processing jscript file: \(error.localizedDescription)")
        }
        return context
    }
}
