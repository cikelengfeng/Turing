//
//  Parameter.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/8/14.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

public struct ParameterDescription: Hashable {
    let name: String
    let type: String
}

public enum StackOP: Hashable {
    case push(symbol: String)
    case pop
}

public struct TransitionDescription: Hashable {
    let name: String
    let checkStackTop: String?
    let stackOP: StackOP?
//    let param: [ParameterDescription]
    
    public init(name: String, checkStackTop: String?, stackOP: StackOP?) {
        self.name = name
        self.checkStackTop = checkStackTop
        self.stackOP = stackOP
    }
    
    public init(name: String) {
        self.init(name: name, checkStackTop: nil, stackOP: nil)
    }
    
    public init(name: String, checkStackTop: String?) {
        self.init(name: name, checkStackTop: checkStackTop, stackOP: nil)
    }
    
    public init(name: String, stackOP: StackOP?) {
        self.init(name: name, checkStackTop: nil, stackOP: stackOP)
    }
    
    public var hashValue: Int {
        get {
            return "TransitionDescription".hashValue ^ name.hashValue
        }
    }
}
