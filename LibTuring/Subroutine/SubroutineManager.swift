//
//  SubroutineManager.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

private class CommandNode {
    var subroutine: Subroutine?
    var subcommands: [String: CommandNode]
    
    init() {
        subcommands = [:]
        subroutine = nil
    }
}

public class SubroutineManager {
    var subroutines: [Subroutine]
    private var commandTrie: CommandNode
    
    public init() {
        subroutines = []
        commandTrie = CommandNode()
    }
    
    public func register(_ subroutine: Subroutine) {
        
        var anchorPoint = commandTrie
        subroutine.commandSequence.forEach { (command) in
            if let c = anchorPoint.subcommands[command] {
                anchorPoint = c
            } else {
                let c = CommandNode()
                anchorPoint.subcommands[command] = c
                anchorPoint = c
            }
        }
        anchorPoint.subroutine = subroutine
    }
    
    private func noSubroutineError() -> String {
        return "no subroutine can handle such input"
    }
    
    public func run() {
        var arguments = CommandLine.arguments
        arguments.removeFirst()
        var commandNode = commandTrie
        var consumedArgIndex = 0
        for argument in arguments {
            if let c = commandNode.subcommands[argument] {
                commandNode = c
                consumedArgIndex += 1
            } else {
                break
            }
        }
        var subArgs: [String] = []
        if consumedArgIndex < arguments.count - 1 {
           subArgs = Array<String>(arguments[consumedArgIndex..<arguments.count])
        }
        
        guard let sr = commandNode.subroutine else {
            fatalError(noSubroutineError())
        }
        sr.run(arguments: subArgs)
    }
    
}
