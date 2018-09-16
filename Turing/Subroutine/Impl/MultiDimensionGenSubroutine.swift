//
//  MultiDimensionGenSubroutine.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/16.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

//private class MDGraphSource: StateMachineSource {
//    
//    
//    let dimensions: [String]
//    var initialVertex: Vertex<String> {
//        get {
//            
//        }
//    }
//    var graph: AbstractGraph<String> {
//        get {
//            
//        }
//    }
//    
//    init(dimensions: [String]) {
//        self.dimensions = dimensions;
//    }
//    
//    
//}

class MultiDimensionGenSubroutine: Subroutine {
    var commandSequence: [String] {
        get {
            return ["md"]
        }
    }
    
    func run(arguments: [String]) {
        guard arguments.count >= 3 else {
            fatalError("缺少参数 outputPath, classPrefix, dimensions")
        }
        let outputPath = arguments[0]
        let classPrefix = arguments[1]
        let dimenstions = Array(arguments[2..<arguments.count])
        
    }
}
