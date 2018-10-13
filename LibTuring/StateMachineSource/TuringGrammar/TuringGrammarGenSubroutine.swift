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
            guard
                let fs = t.transition_from(),
                let ts = t.transition_to(),
                let input = t.input()
                else {
                return
            }
            let fv = graph.createVertex(fs.IDENTIFIER()!.getText())
            let tv = graph.createVertex(ts.IDENTIFIER()!.getText())
            
            let checkStackSymbol: String?
            let pushOrPop: StackOP?
            if let stackOP = t.stack_op() {
                if let checkStack = stackOP.check_stack() {
                    checkStackSymbol = checkStack.IDENTIFIER()!.getText()
                } else {
                    checkStackSymbol = nil
                }
                if let push = stackOP.push_stack() {
                    pushOrPop = .push(symbol: push.IDENTIFIER()!.getText())
                } else if let _ = stackOP.pop_stack() {
                    pushOrPop = .pop
                } else {
                    pushOrPop = nil
                }
            } else {
                checkStackSymbol = nil
                pushOrPop = nil
            }
            
            graph.addDirectedEdge(fv, to: tv, withWeight: 1, desc: TransitionDescription(name: input.IDENTIFIER()!.getText(), checkStackTop: checkStackSymbol, stackOP: pushOrPop))
        }
        let initialVertex = graph.createVertex(initial.IDENTIFIER()!.getText())
        return (graph: graph, initialVertex: initialVertex)
    }
}
