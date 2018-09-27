//
//  MultiDimensionGenSubroutine.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/16.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

private class MDGraphSource: StateMachineSource {
    
    
    let dimensions: [String]
    private(set) var initialVertex: Vertex<String>
    private(set) var graph: AbstractGraph<String>
    
    init(dimensions: [String]) {
        self.dimensions = dimensions;
        (self.graph, self.initialVertex) = MDGraphSource.genGraph(dimensions: dimensions)
    }
    
    private static func genGraph(dimensions: [String]) -> (graph:AbstractGraph<String>, initial:Vertex<String>)
    {
        let stateCount = NSDecimalNumber(decimal:pow(2, dimensions.count)).intValue
        let graph = AdjacencyMatrixGraph<String>()
        var vertices: [Vertex<String>] = []
        
        for loopState in 0..<stateCount {
            let v = graph.createVertex("S\(loopState)")
            vertices.append(v)
        }
        
        for loopState in 0..<stateCount {
            let v = vertices[loopState]
            for bit in 0..<dimensions.count {
                let mark = 1 << bit
                //将loopstate当前bit位取反，就是扇出节点的索引
                //如0001代表四个维度，前三个维度没有值，第四个维度有值
                //这个状态的扇出只有四个：1001，0101，0011，0000，即每个bit位依次取反（这个前提是一次只能改变一个维度的值）
                let fanoutIndex = (loopState & (~mark)) | (loopState ^ mark)
                let dismiss = (fanoutIndex & mark) == 0
                let fanoutV = vertices[fanoutIndex]
                let changedDimension = dimensions[bit]
                graph.addDirectedEdge(v, to: fanoutV, withWeight: 1, desc: TransitionDescription(name: (dismiss ? "Dismiss": "Get") + changedDimension, param: []))
            }
        }
        return (graph, vertices[0])
    }
}

public class MultiDimensionGenSubroutine: Subroutine {
    
    public init() {
        
    }
    
    public var commandSequence: [String] {
        get {
            return ["md"]
        }
    }
    
    public func run(arguments: [String]) {
        guard arguments.count >= 3 else {
            fatalError("缺少参数 outputPath, classPrefix, dimensions")
        }
        let outputPath = arguments[0]
        let classPrefix = arguments[1]
        let dimenstions = Array(arguments[2..<arguments.count])
        guard dimenstions.count < 10 else {
            fatalError("输入的维度太多，这样创建出来的状态机太大了，根本没法用")
        }
        let source = MDGraphSource(dimensions: dimenstions)
        let codeGen = ObjectiveCGen(graph: source.graph, codePath: outputPath, name: classPrefix, initialVertex: source.initialVertex)
        codeGen.headerTopCode = "//这是自动生成的文件，不要修改，否则你的修改将被覆盖"
        codeGen.implTopCode = codeGen.headerTopCode
        codeGen.gen()
    }
}
