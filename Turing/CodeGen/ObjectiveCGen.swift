//
//  ObjectiveCGen.swift
//  WarMachine
//
//  Created by 徐 东 on 2018/8/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation


class ObjectiveCGen: CodeGen {
    
    private let graph: AbstractGraph<String>
    private let name: String
    private let initialState: Vertex<String>
    private let codePath: String
    private var header: CodeWriter = CodeWriter()
    private var impl: CodeWriter = CodeWriter()
    var headerImportFileCode: String?
    var implImportFileCode: String?
    
    required convenience init(source: StateMachineSource) {
        self.init(graph: source.graph, codePath: source.codePath, name: source.name, initialVertex: source.initialVertex)
    }
    
    init(graph: AbstractGraph<String>, codePath: String, name: String, initialVertex: Vertex<String>) {
        self.graph = graph
        self.name = name
        self.initialState = initialVertex
        self.codePath = codePath
    }
    
    private func setupWriter() {
        let headerFilePath = codePath + headerFileName()
        header.setup(headerFilePath)
        let implFilePath = codePath + stateMachineClassName() + ".m"
        impl.setup(implFilePath)
    }
    
    private func teardownWriter() {
        header.teardown()
        impl.teardown()
    }
    
    func gen() {
        setupPublicMethodStore()
        setupWriter()
        
        writeImportHeaderCode(header)
        writeObserverDefinationCode(header)
        writeDelegateDefinationCode(header)
        writeStateDefinationCode(header)
        writeInterfaceDefinationCode(header)
        
        
        
        writeImportImplCode(impl)
        writeMemberImplCode(impl)
        writeImplDefinationCode(impl)
        
        teardownWriter()
        
    }
    
    private func write(code: String, byFileHandle fileHandle: FileHandle) {
        guard let data = code.data(using: String.Encoding.utf8) else {
            return
        }
        fileHandle.write(data)
    }
    
    private func stateEnumName() -> String {
        return "\(self.name)State"
    }
    
    private func stateName(forState state: Vertex<String>) -> String {
        return stateEnumName() + graph.stateName(state)
    }
    
    private func writeStateDefinationCode(_ writer: CodeWriter) {
        writer.writeLine("typedef NS_ENUM(NSUInteger, \(stateEnumName())) {")
        writer.pushIndent()
        for state in graph.vertices {
            writer.writeLine(stateName(forState: state) + ",")
        }
        writer.popIndent()
        writer.writeLine("};")
    }
    
    private func writeInterfaceDefinationCode(_ writer: CodeWriter) {
        writer.writeLine("@interface \(stateMachineClassName()): NSObject")
        writePublicMethodInterfaceCode(writer)
        writeMemberInferfaceCode(writer)
        writer.writeLine("@end")
    }
    
    private func headerFileName() -> String {
        return stateMachineClassName() + ".h"
    }
    
    private func writeImportHeaderCode(_ writer: CodeWriter) {
        writer.writeLine("#import <Foundation/Foundation.h>")
        if let customImport = headerImportFileCode {
            writer.writeLine(customImport)
        }
        writer.writeLine("@class \(stateMachineClassName());")
    }
    
    private func writeImportImplCode(_ writer: CodeWriter) {
        if let customImport = implImportFileCode {
            writer.writeLine(customImport)
        }
        writer.writeLine("#import \"\(headerFileName())\"")
    }
    
    private func writeImplDefinationCode(_ writer: CodeWriter) {
        writer.writeLine("@implementation \(stateMachineClassName())")
        writeInitMethodCode(writer)
        writeObserverSetterCode(writer)
        writeStateSetterCode(writer)
        writePublicMethodImplCode(writer)
        writer.writeLine("@end")
    }
    
    private func writeMemberInferfaceCode(_ writer: CodeWriter) {
        header.writeLine("@property (assign, nonatomic, readonly) \(stateEnumName()) state;")
        writer.writeLine("@property (weak, nonatomic) id<\(obersverProtocolName())> observer;")
        writer.writeLine("@property (weak, nonatomic) id<\(delegateProtocolName())> delegate;")
    }
    
    private func writeMemberImplCode(_ writer: CodeWriter) {
        writer.writeLine("@interface \(stateMachineClassName())()")
        writer.writeLine("@property (assign, nonatomic) \(stateEnumName()) state;")
        writer.writeLine("@property (assign, nonatomic) BOOL transitionOcurred;")
        writer.writeLine("@end")
    }
    
    private func writeInitMethodCode(_ writer: CodeWriter) {
        writer.writeLine("- (instancetype)init {")
        writer.pushIndent()
        writer.writeLine("self = [super init];")
        writer.writeLine("if (self) {")
        writer.pushIndent()
        writer.writeLine("_state = \(stateName(forState: initialState));")
        writer.writeLine("_transitionOcurred = NO;")
        writer.popIndent()
        writer.writeLine("}")
        writer.writeLine("return self;")
        writer.popIndent()
        writer.writeLine("}")
    }
    
    private func writeObserverSetterCode(_ writer: CodeWriter) {
        writer.writeLine("- (void)setObserver:(id<\(obersverProtocolName())>)observer {")
        writer.pushIndent()
        writer.writeLine("BOOL obChanged = _observer != observer;")
        writer.writeLine("_observer = observer;")
        writer.writeLine("if (!self.transitionOcurred && obChanged) {")
        writer.pushIndent()
        writeObserverEnterStateMethodCallCode(forState: initialState, writer);
        writer.popIndent()
        writer.writeLine("}")
        writer.popIndent()
        writer.writeLine("}")
    }
    
    private func writeStateSetterCode(_ writer: CodeWriter) {
        writer.writeLine("- (void)setState:(\(stateEnumName()))state {")
        writer.pushIndent()
        writer.writeLine("_state = state;")
        writer.writeLine("self.transitionOcurred = YES;")
        writer.popIndent()
        writer.writeLine("}")
    }
    
    private func writePublicMethodInterfaceCode(_ writer: CodeWriter) {
        for method in publicMethodStore.keys {
            var paramCode: String = ""
            if !method.param.isEmpty {
                paramCode = "With"
                for paramDesc in method.param {
                    paramCode += paramDesc.name + ":(" + paramDesc.type + ")" + paramDesc.name + " "
                }
            }
            
            writer.writeLine("- (void)do\(method.name)\(paramCode);")
        }
    }
    
    private func writePublicMethodImplCode(_ writer: CodeWriter) {
        let shouldTransitionVarName = "shouldTransition"
        for method in publicMethodStore {
            var paramCode: String = ""
            let transition = method.key
            if !transition.param.isEmpty {
                paramCode = "With"
                for paramDesc in transition.param {
                    paramCode += paramDesc.name + ":(" + paramDesc.type + ")" + paramDesc.name + " "
                }
            }
            writer.writeLine("- (void)do\(transition.name)\(paramCode) {")
            writer.pushIndent()
            if method.value.count == 1 {
                let edge = method.value[0]
                
                writer.writeLine("if (\(stateName(forState: edge.from)) != self.state) {")
                writer.pushIndent()
                writer.writeLine("return;")
                writer.popIndent()
                writer.writeLine("}")
                writer.writeLine("BOOL \(shouldTransitionVarName) = YES;")
                writeDelegateShouldTransiteStateMethodCallCode(forTransition: edge, shouldTransiteVarName: shouldTransitionVarName, writer)
                writer.writeLine("if (!\(shouldTransitionVarName)) {")
                writer.pushIndent()
                writer.writeLine("return;")
                writer.popIndent()
                writer.writeLine("}")
                writeObserverExitStateMethodCallCode(forState: edge.from, writer)
                writer.writeLine("self.state = \(stateName(forState: edge.to));")
                writeObserverEnterStateMethodCallCode(forState: edge.to, writer)
                
            } else {
                for edge in method.value {
                    writer.writeLine("if (\(stateName(forState: edge.from)) == self.state) {")
                    writer.pushIndent()
                    writer.writeLine("BOOL \(shouldTransitionVarName) = YES;")
                    writeDelegateShouldTransiteStateMethodCallCode(forTransition: edge, shouldTransiteVarName: shouldTransitionVarName, writer)
                    writer.writeLine("if (\(shouldTransitionVarName)) {")
                    writer.pushIndent()
                    writeObserverExitStateMethodCallCode(forState: edge.from, writer)
                    writer.writeLine("self.state = \(stateName(forState: edge.to));")
                    writeObserverEnterStateMethodCallCode(forState: edge.to, writer)
                    writer.popIndent()
                    writer.writeLine("}")
                    writer.popIndent()
                    writer.writeLine("}")
                }
            }
            writer.popIndent()
            writer.writeLine("}")
            
        }
    }
    
    private func obersverProtocolName() -> String {
        return "\(name)Observer"
    }
    
    private func stateMachineClassName() -> String {
        return "\(name)StateMachine"
    }
    
    private func delegateProtocolName() -> String {
        return "\(name)Delegate"
    }
    
    private func writeObserverDefinationCode(_ writer: CodeWriter) {
        writer.writeLine("@protocol \(obersverProtocolName()) <NSObject>")
        writer.writeLine("@optional")
        for state in graph.vertices {
            writeObserverEnterStateMethodDefinationCode(forState: state, writer)
            writeObserverExitStateMethodDefinationCode(forState: state, writer)
        }
        writer.writeLine("@end")
    }
    
    private static let OberserEnterStateMethodPrefix: String = "onEnter"
    private static let OberserExitStateMethodPrefix: String = "onExit"
    
    private func writeObserverEnterStateMethodDefinationCode(forState state: Vertex<String>, _ writer: CodeWriter) {
        writer.writeLine("-(void)\(ObjectiveCGen.OberserEnterStateMethodPrefix)\(graph.stateName(state)):(\(stateMachineClassName()) *)\(name);")
    }
    
    private func writeObserverEnterStateMethodCallCode(forState state: Vertex<String>, _ writer: CodeWriter) {
        writer.writeLine("if ([self.observer respondsToSelector:@selector(\(ObjectiveCGen.OberserEnterStateMethodPrefix)\(graph.stateName(state)):)]) {")
        writer.pushIndent()
        writer.writeLine("[self.observer \(ObjectiveCGen.OberserEnterStateMethodPrefix)\(graph.stateName(state)):self];")
        writer.popIndent()
        writer.writeLine("}")
    }
    private func writeObserverExitStateMethodDefinationCode(forState state: Vertex<String>, _ writer: CodeWriter) {
        writer.writeLine("-(void)\(ObjectiveCGen.OberserExitStateMethodPrefix)\(graph.stateName(state)):(\(stateMachineClassName()) *)\(name);")
    }
    
    private func writeObserverExitStateMethodCallCode(forState state: Vertex<String>, _ writer: CodeWriter) {
        writer.writeLine("if ([self.observer respondsToSelector:@selector(\(ObjectiveCGen.OberserExitStateMethodPrefix)\(graph.stateName(state)):)]) {")
        writer.pushIndent()
        writer.writeLine("[self.observer \(ObjectiveCGen.OberserExitStateMethodPrefix)\(graph.stateName(state)):self];")
        writer.popIndent()
        writer.writeLine("}")
    }
    
    
    private func writeDelegateDefinationCode(_ writer: CodeWriter) {
        writer.writeLine("@protocol \(delegateProtocolName()) <NSObject>")
        writer.writeLine("@optional")
        for transition in graph.edges {
            writeDelegateShouldTransiteStateMethodDefinationCode(forTransition: transition, writer)
        }
        writer.writeLine("@end")
    }
    
    static let DelegateShouldTransitionStateMethodPrefix: String = "shouldTransiteFrom"
    static let DelegateShouldTransitionStateMethodMiddle: String = "To"
    
    
    private enum MethodCodeType {
        case defination
        case selector
        case call
    }
    
    private func delegateShouldTransiteStateMethodCode(forTransition transition: Edge<String>, type: MethodCodeType) -> String {
        var codeSnippets: [String] = []
        if type == .defination {
            codeSnippets.append("-(BOOL)")
        }
        
        codeSnippets.append("\(ObjectiveCGen.DelegateShouldTransitionStateMethodPrefix)\(graph.stateName(transition.from))\(ObjectiveCGen.DelegateShouldTransitionStateMethodMiddle)\(graph.stateName(transition.to))")
        switch type {
        case .defination:
            codeSnippets.append("WithStateMachine:(\(stateMachineClassName()) *)stateMachine ")
        case .call:
            codeSnippets.append("WithStateMachine:self ")
        case .selector:
            codeSnippets.append("WithStateMachine:")
        }
        for paramDesc in graph.transition(transition).param {
            switch type {
            case .defination:
                codeSnippets.append("\(paramDesc.name):(\(paramDesc.type))\(paramDesc.name) ")
            case .call:
                codeSnippets.append("\(paramDesc.name):\(paramDesc.name) ")
            case .selector:
                codeSnippets.append("\(paramDesc.name):")
            }
        }
        return codeSnippets.joined(separator: "")
    }
    
    private func writeDelegateShouldTransiteStateMethodDefinationCode(forTransition transition: Edge<String>, _ writer: CodeWriter) {
        writer.writeLine(delegateShouldTransiteStateMethodCode(forTransition: transition, type: .defination) + ";")
    }
    
    private func writeDelegateShouldTransiteStateMethodCallCode(forTransition transition: Edge<String>, shouldTransiteVarName: String, _ writer: CodeWriter) {
        writer.writeLine("if ([self.delegate respondsToSelector:@selector(\(delegateShouldTransiteStateMethodCode(forTransition: transition, type: .selector)))]) {")
        writer.pushIndent()
        writer.writeLine("\(shouldTransiteVarName) = [self.delegate \(delegateShouldTransiteStateMethodCode(forTransition: transition, type: .call))];")
        writer.popIndent()
        writer.writeLine("}")
    }
    
    
    var publicMethodStore: [TransitionDescription: [Edge<String>]] = [:]
    
    private func setupPublicMethodStore() {
        for edge in graph.edges {
            let transition = graph.transition(edge)
            var edgesWithTheSameTransition = publicMethodStore[transition] ?? []
            edgesWithTheSameTransition.append(edge)
            publicMethodStore[transition] = edgesWithTheSameTransition
        }
    }
}
