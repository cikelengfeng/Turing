//
//  main.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/7/29.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

func main() {
    guard CommandLine.argc >= 3 else {
        fatalError("缺少参数 processonFilePath, outputPath, classPrefix")
    }
    // arguments[0] is always the program_name
//    let processonFilePath = "/Users/xudong/Downloads/Light.pos"
//    let outputPath = "/Users/xudong/git/Turing/GenCodeTests/"
//    let classPrefix = "Test"
    let processonFilePath = CommandLine.arguments[1]
    let outputPath = CommandLine.arguments[2]
    let classPrefix = CommandLine.arguments[3]
    
    let processon = ProcessonDiagram(filePath: processonFilePath, codePath: outputPath, name: classPrefix)
    let codeGen = ObjectiveCGen(source: processon)
    codeGen.gen()
}

main()
