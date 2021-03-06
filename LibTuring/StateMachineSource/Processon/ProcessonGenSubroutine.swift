//
//  GenSubroutine.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

public class ProcessonGenSubroutine: Subroutine {
    
    public init() {
        
    }
    
    public var commandSequence: [String] {
        get {
            return ["pos"]
        }
    }
    
    public func run(arguments: [String]) {
        guard arguments.count >= 3 else {
            fatalError("缺少参数 processonFilePath, outputPath, classPrefix")
        }
        let processonFilePath = arguments[0]
        let outputPath = arguments[1]
        let classPrefix = arguments[2]
        
        let processon = ProcessonDiagram(filePath: processonFilePath)
        let codeGen = ObjectiveCGen(graph: processon.graph, codePath: outputPath, name: classPrefix, initialVertex: processon.initialVertex)
        codeGen.headerTopCode = "//这是自动生成的文件，不要修改，否则你的修改将被覆盖"
        codeGen.implTopCode = codeGen.headerTopCode
        codeGen.gen()
    }
}
