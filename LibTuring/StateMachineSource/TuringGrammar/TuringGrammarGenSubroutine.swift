//
//  TuringGrammarGenSubroutine.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/21.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation
import Antlr4

public class TuringGrammarGenSubroutine: Subroutine {
    
    public init() {
        
    }
    
    
    public var commandSequence: [String] {
        get {
            return ["tg"]
        }
    }
    
    public func run(arguments: [String]) {
        guard arguments.count >= 3 else {
            fatalError("缺少参数 turingFilePath, outputPath, classPrefix")
        }
        // arguments[0] is always the program_name
        //        let processonFilePath = "/Users/xudong/Downloads/Light.pos"
        //        let outputPath = "/Users/xudong/git/Turing/GenCodeTests/"
        //        let classPrefix = "Test"
        let turingFilePath = arguments[0]
        let outputPath = arguments[1]
        let classPrefix = arguments[2]
        do {
            let stream = try ANTLRFileStream(turingFilePath)
            let lexer = TuringLexer(stream)
            let tokenStream = CommonTokenStream(lexer)
            let parser = try TuringParser(tokenStream)
            let (graph, initial) = convert(entryContext: try parser.entry())
            let gen = ObjectiveCGen(graph: graph, codePath: outputPath, name: classPrefix, initialVertex: initial)
            gen.gen()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    private func convert(entryContext: TuringParser.EntryContext) -> (graph: AbstractGraph<String>, initialVertex: Vertex<String>) {
        let graph = AdjacencyMatrixGraph<String>()
        guard let stateMachineDef = entryContext.state_machine_define() else {
            fatalError("missing state machine defination!!!")
        }
        guard let initial = stateMachineDef.initial_define() else {
            fatalError("missing initial state defination!!!")
        }
        let transitions = stateMachineDef.transition_define()
        guard !transitions.isEmpty else {
            fatalError("missing state machine transition is empty!!!")
        }
        transitions.forEach { (t) in
            guard let fs = t.transition_from(),
                let ts = t.transition_to(),
                let input = t.input()
                else {
                return
            }
            let fv = graph.createVertex(fs.IDENTIFIER()!.getText())
            let tv = graph.createVertex(ts.IDENTIFIER()!.getText())
            graph.addDirectedEdge(fv, to: tv, withWeight: 1, desc: TransitionDescription(name: input.IDENTIFIER()!.getText(), param: []))
        }
        let initialVertex = graph.createVertex(initial.IDENTIFIER()!.getText())
        return (graph: graph, initialVertex: initialVertex)
    }
}
