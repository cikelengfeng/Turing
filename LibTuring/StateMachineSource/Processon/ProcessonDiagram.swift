//
//  ProcessonDiagram.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/9/12.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

class ProcessonDiagram: StateMachineSource {
    
    let fileReader: ProcessonFileReader
    var graph: AbstractGraph<String> {
        get {
            return fileReader.getGraph()
        }
    }
    var initialVertex: Vertex<String> {
        get {
            return fileReader.initialVertex
        }
    }
    
    init(filePath: String) {
        fileReader = ProcessonFileReader(filePath: filePath)
    }

}
