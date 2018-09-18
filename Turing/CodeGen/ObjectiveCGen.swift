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
    private var header: ObjectiveCWriter = ObjectiveCWriter()
    private var impl: ObjectiveCWriter = ObjectiveCWriter()
    var headerImportFileCode: String?
    var headerTopCode: String?
    var implImportFileCode: String?
    var implTopCode: String?
    
    
    required init(graph: AbstractGraph<String>, codePath: String, name: String, initialVertex: Vertex<String>) {
        self.graph = graph.upperCased()
        self.name = name.upperFirstLetter()
        self.initialState = self.graph.createUpperCasedVertex(initialVertex)
        self.codePath = codePath
    }
    
    private func setupWriter() {
        let headerFilePath = codePath + headerFileName()
        header.setup(filePath: headerFilePath)
        let implFilePath = codePath + stateMachineClassName() + ".m"
        impl.setup(filePath: implFilePath)
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
    
    private func stateEnumName() -> String {
        return "\(self.name)State"
    }
    
    private func stateName(forState state: Vertex<String>) -> String {
        return stateEnumName() + graph.stateName(state)
    }
    
    private func writeStateDefinationCode(_ writer: ObjectiveCWriter) {
        let cases = sortedVertices().map { (v) -> String in
            return stateName(forState: v)
        }
        writer.writeEnumDefination(rawType: "NSUInteger", name: stateEnumName(), cases: cases)
    }
    
    private func writeInterfaceDefinationCode(_ writer: ObjectiveCWriter) {
        writer.writeInterface(name: stateMachineClassName(), superInterface: "NSObject", protocolArr: []) { (w) in
            self.writePublicMethodInterfaceCode(w)
            self.writeMemberInferfaceCode(w)
        }
    }
    
    private func headerFileName() -> String {
        return stateMachineClassName() + ".h"
    }
    
    private func writeImportHeaderCode(_ writer: ObjectiveCWriter) {
        if let topCode = headerTopCode {
            writer.writeLine(topCode)
        }
        writer.writeSharpImport(file: "<Foundation/Foundation.h>")
        if let customImport = headerImportFileCode {
            writer.writeLine(customImport)
        }
        writer.writeForwardClassDeclaration(type: stateMachineClassName())
    }
    
    private func writeImportImplCode(_ writer: ObjectiveCWriter) {
        if let topCode = implTopCode {
            writer.writeLine(topCode)
        }
        writer.writeSharpImport(file: "\"\(headerFileName())\"")
        if let customImport = implImportFileCode {
            writer.writeLine(customImport)
        }
    }
    
    private func writeImplDefinationCode(_ writer: ObjectiveCWriter) {
        writer.writeImplementation(name: stateMachineClassName(), protocolArr: []) { (w) in
            self.writeInitMethodCode(w)
            self.writeObserverSetterCode(w)
            //        writeStateSetterCode(writer)
            self.writeObserverEnterStateMethodDefinationCode(w)
            self.writePublicMethodImplCode(w)
        }
    }
    
    private func writeMemberInferfaceCode(_ writer: ObjectiveCWriter) {
        writer.writeProperty(lifeCycle: [.assign], atomic: false, rw: [.readonly], selector: [], type: stateEnumName(), name: "state")
        writer.writeLine("//default is YES")
        writer.writeProperty(lifeCycle: [.assign], atomic: false, rw: [], selector: [], type: "BOOL", name: "shouldEnterCurrentStateWhenObserverChanged")
        writer.writeProperty(lifeCycle: [.weak], atomic: false, rw: [], selector: [], type: "id<\(obersverProtocolName())>", name: "observer")
        writer.writeProperty(lifeCycle: [.weak], atomic: false, rw: [], selector: [], type: "id<\(delegateProtocolName())>", name: "delegate")
        
    }
    
    private func writeMemberImplCode(_ writer: ObjectiveCWriter) {
        writer.writeInterface(name: stateMachineClassName(), categoryName: "", protocolArr: []) { (w) in
            w.writeProperty(lifeCycle: [.assign], atomic: false, rw: [], selector: [], type: self.stateEnumName(), name: "state")
        }
    }
    
    private func writeInitMethodCode(_ writer: ObjectiveCWriter) {
        writer.writeMethodDefination(isClassMethod: false, returnType: "instancetype", prefix: "initWith", fragments: [(name: "State", param: (type: stateEnumName(), name: "state"))]) { (w) in
            writer.pushIndent()
            writer.writeLine("self = [super init];")
            writer.writeLine("if (self) {")
            writer.pushIndent()
            writer.writeLine("_state = state;")
            writer.writeLine("_shouldEnterCurrentStateWhenObserverChanged = YES;")
            writer.popIndent()
            writer.writeLine("}")
            writer.writeLine("return self;")
            writer.popIndent()
        }
        writer.writeMethodDefination(isClassMethod: false, returnType: "instancetype", prefix: "init", fragments: []) { (w) in
            writer.pushIndent()
            writer.writeLine("return [self initWithState:\(self.stateName(forState: self.initialState))];")
            writer.popIndent()
        }
    }
    
    private func writeObserverSetterCode(_ writer: ObjectiveCWriter) {
        writer.writeLine("- (void)setObserver:(id<\(obersverProtocolName())>)observer {")
        writer.pushIndent()
        writer.writeLine("BOOL obChanged = _observer != observer;")
        writer.writeLine("_observer = observer;")
        writer.writeLine("if (!self.shouldEnterCurrentStateWhenObserverChanged && obChanged) {")
        writer.pushIndent()
        writeObserverEnterCurrentStateMethodCallCode(observerVarName: "_observer" ,writer)
        writer.popIndent()
        writer.writeLine("}")
        writer.popIndent()
        writer.writeLine("}")
    }
    
//    private func writeStateSetterCode(_ writer: ObjectiveCWriter) {
//        writer.writeLine("- (void)setState:(\(stateEnumName()))state {")
//        writer.pushIndent()
//        writer.writeLine("_state = state;")
//        writer.popIndent()
//        writer.writeLine("}")
//    }
    
    private func writePublicMethodInterfaceCode(_ writer: ObjectiveCWriter) {
        for method in publicMethodStore.sortedKeysInLocalizedStandard() {
            
            let f = method.param.map { (p) -> (name: String, param: (type: String, name: String)?) in
                return (name: p.name, param: (type: p.type, name: p.name.lowerFirstLetter()))
            }
            
            let with = f.isEmpty ? "": "With"
            writer.writeMethodDeclaration(isClassMethod: false, returnType: nil, prefix: "do" + method.name + with, fragments: f)
        }
        
        writer.writeMethodDeclaration(isClassMethod: false, returnType: "instancetype", prefix: "initWith", fragments: [(name: "State", param: (type: stateEnumName(), name: "state"))])
    }
    
    private func writePublicMethodImplCode(_ writer: ObjectiveCWriter) {
        let shouldTransitionVarName = "shouldTransition"
        for method in publicMethodStore.sortedKeysInLocalizedStandard() {
            
            let edges = publicMethodStore[method]!
            let f = method.param.map { (p) -> (name: String, param: (type: String, name: String)?) in
                return (name: p.name, param: (type: p.type, name: p.name.lowerFirstLetter()))
            }
            
            let with = f.isEmpty ? "": "With"
            writer.writeMethodDefination(isClassMethod: false, returnType: nil, prefix: "do" + method.name + with, fragments: f) { (w) in
                w.pushIndent()
                if edges.count == 1 {
                    let edge = edges[0]
                    w.writeLine("if (\(self.stateName(forState: edge.from)) != self.state) {")
                    w.pushIndent()
                    w.writeLine("return;")
                    w.popIndent()
                    w.writeLine("}")
                    w.writeLine("BOOL \(shouldTransitionVarName) = YES;")
                    self.writeDelegateShouldTransiteStateMethodCallCode(forTransition: edge, desc: method, shouldTransiteVarName: shouldTransitionVarName, w)
                    w.writeLine("if (!\(shouldTransitionVarName)) {")
                    w.pushIndent()
                    w.writeLine("return;")
                    w.popIndent()
                    w.writeLine("}")
                    self.writeObserverExitStateMethodCallCode(forState: edge.from, w)
                    w.writeLine("self.state = \(self.stateName(forState: edge.to));")
                    self.writeObserverEnterStateMethodCallCode(observerVarName: "self.observer" ,forState: edge.to, w)
                } else {
                    for edge in self.sortedEdges(edges) {
                        w.writeLine("if (\(self.stateName(forState: edge.from)) == self.state) {")
                        w.pushIndent()
                        w.writeLine("BOOL \(shouldTransitionVarName) = YES;")
                        self.writeDelegateShouldTransiteStateMethodCallCode(forTransition: edge, desc: method, shouldTransiteVarName: shouldTransitionVarName, w)
                        w.writeLine("if (\(shouldTransitionVarName)) {")
                        w.pushIndent()
                        self.writeObserverExitStateMethodCallCode(forState: edge.from, w)
                        w.writeLine("self.state = \(self.stateName(forState: edge.to));")
                        self.writeObserverEnterStateMethodCallCode(observerVarName: "self.observer" ,forState: edge.to, w)
                        w.writeLine("return;")
                        w.popIndent()
                        w.writeLine("}")
                        w.popIndent()
                        w.writeLine("}")
                    }
                }
                w.popIndent()
            }
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
    
    private func writeObserverDefinationCode(_ writer: ObjectiveCWriter) {
        writer.writeProtocolDeclaration(name: obersverProtocolName(), protocolArr: ["NSObject"]) { (w) in
            writer.writeLine("@optional")
            for state in self.sortedVertices() {
                self.writeObserverEnterStateMethodDefinationCode(forState: state, writer)
                self.writeObserverExitStateMethodDefinationCode(forState: state, writer)
            }
        }
    }
    
    private static let OberserEnterStateMethodPrefix: String = "onEnter"
    private static let OberserExitStateMethodPrefix: String = "onExit"
    
    private func writeObserverEnterStateMethodDefinationCode(forState state: Vertex<String>, _ writer: ObjectiveCWriter) {
        writer.writeMethodDeclaration(isClassMethod: false, returnType: nil, prefix: ObjectiveCGen.OberserEnterStateMethodPrefix, fragments: [(name: graph.stateName(state), param: (type: stateMachineClassName() + "*", name: "stateMachine"))])
    }
    
    private func writeObserverEnterCurrentStateMethodCallCode(observerVarName: String, _ writer: ObjectiveCWriter) {
        writer.writeLine("[self notifyObserverEnterCurrentState:\(observerVarName)];")
    }
    
    private func writeObserverEnterStateMethodDefinationCode(_ writer: ObjectiveCWriter) {
        writer.writeMethodDefination(isClassMethod: false, returnType: nil, prefix: "notifyObserverEnter", fragments: [(name: "CurrentState", param: (type: "id<\(obersverProtocolName())>", name: "obs"))]) { (w) in
            w.pushIndent()
            w.writeLine("switch (self.state) {")
            w.pushIndent()
            for state in self.sortedVertices() {
                w.writeLine("case \(self.stateName(forState: state)): {")
                w.pushIndent()
                self.writeObserverEnterStateMethodCallCode(observerVarName: "obs" ,forState: state, w)
                w.writeLine("break;")
                w.popIndent()
                w.writeLine("}")
            }
            w.popIndent()
            w.writeLine("}")
            w.popIndent()
        }
    }
    
    private func writeObserverEnterStateMethodCallCode(observerVarName: String, forState state: Vertex<String>, _ writer: ObjectiveCWriter) {
        writer.writeLine("if ([\(observerVarName) respondsToSelector:@selector(\(ObjectiveCGen.OberserEnterStateMethodPrefix)\(graph.stateName(state)):)]) {")
        writer.pushIndent()
        writer.writeLine("[\(observerVarName) \(ObjectiveCGen.OberserEnterStateMethodPrefix)\(graph.stateName(state)):self];")
        writer.popIndent()
        writer.writeLine("}")
    }
    private func writeObserverExitStateMethodDefinationCode(forState state: Vertex<String>, _ writer: ObjectiveCWriter) {
        writer.writeMethodDeclaration(isClassMethod: false, returnType: nil, prefix: ObjectiveCGen.OberserExitStateMethodPrefix, fragments: [(name: graph.stateName(state), param: (type: stateMachineClassName() + "*", name: "stateMachine"))])
    }
    
    private func writeObserverExitStateMethodCallCode(forState state: Vertex<String>, _ writer: ObjectiveCWriter) {
        writer.writeLine("if ([self.observer respondsToSelector:@selector(\(ObjectiveCGen.OberserExitStateMethodPrefix)\(graph.stateName(state)):)]) {")
        writer.pushIndent()
        writer.writeLine("[self.observer \(ObjectiveCGen.OberserExitStateMethodPrefix)\(graph.stateName(state)):self];")
        writer.popIndent()
        writer.writeLine("}")
    }
    
    
    private func writeDelegateDefinationCode(_ writer: ObjectiveCWriter) {
        writer.writeProtocolDeclaration(name: delegateProtocolName(), protocolArr: ["NSObject"]) { (w) in
            w.writeLine("@optional")
            for transition in self.sortedEdges() {
                self.sortedDesc(transition).forEach({ (desc) in
                    self.writeDelegateShouldTransiteStateMethodDefinationCode(forTransition: transition, desc: desc, w)
                })
            }
        }
    }
    
    static let DelegateShouldTransitionStateMethodPrefix: String = "shouldTransiteFrom"
    static let DelegateShouldTransitionStateMethodMiddle: String = "To"
    
    
    private enum MethodCodeType {
        case defination
        case selector
        case call
    }
    
    private func delegateShouldTransiteStateMethodCode(forTransition transition: Edge<String>, desc: TransitionDescription, type: MethodCodeType) -> String {
        var codeSnippets: [String] = []
        if type == .defination {
            codeSnippets.append("-(BOOL)")
        }
        
        codeSnippets.append("\(ObjectiveCGen.DelegateShouldTransitionStateMethodPrefix)\(graph.stateName(transition.from))\(ObjectiveCGen.DelegateShouldTransitionStateMethodMiddle)\(graph.stateName(transition.to))When\(desc.name)")
        switch type {
        case .defination:
            codeSnippets.append("WithStateMachine:(\(stateMachineClassName()) *)stateMachine ")
        case .call:
            codeSnippets.append("WithStateMachine:self ")
        case .selector:
            codeSnippets.append("WithStateMachine:")
        }
        for paramDesc in desc.param {
            switch type {
            case .defination:
                //后边留一个空格是为了多参数情况下中间有个空格分开，别删哈
                codeSnippets.append("\(paramDesc.name):(\(paramDesc.type))\(paramDesc.name.lowerFirstLetter()) ")
            case .call:
                codeSnippets.append("\(paramDesc.name):\(paramDesc.name.lowerFirstLetter()) ")
            case .selector:
                codeSnippets.append("\(paramDesc.name):")
            }
        }
        return codeSnippets.joined(separator: "")
    }
    
    private func writeDelegateShouldTransiteStateMethodDefinationCode(forTransition transition: Edge<String>, desc: TransitionDescription, _ writer: ObjectiveCWriter) {
        writer.writeLine(delegateShouldTransiteStateMethodCode(forTransition: transition, desc: desc, type: .defination) + ";")
    }
    
    private func writeDelegateShouldTransiteStateMethodCallCode(forTransition transition: Edge<String>, desc: TransitionDescription, shouldTransiteVarName: String, _ writer: ObjectiveCWriter) {
        writer.writeLine("if ([self.delegate respondsToSelector:@selector(\(delegateShouldTransiteStateMethodCode(forTransition: transition, desc: desc, type: .selector)))]) {")
        writer.pushIndent()
        writer.writeLine("\(shouldTransiteVarName) = [self.delegate \(delegateShouldTransiteStateMethodCode(forTransition: transition, desc: desc, type: .call))];")
        writer.popIndent()
        writer.writeLine("}")
    }
    
    
    var publicMethodStore: [TransitionDescription: [Edge<String>]] = [:]
    
    //有很多边的TransitionDescription是一样的，这些边会合并为一个方法
    private func setupPublicMethodStore() {
        for edge in graph.edges {
            graph.transitionDesc(edge).forEach { (transition) in
                var edgesWithTheSameTransition = publicMethodStore[transition] ?? []
                edgesWithTheSameTransition.append(edge)
                publicMethodStore[transition] = edgesWithTheSameTransition
            }
        }
    }
    
    private func sortedVertices() -> [Vertex<String>] {
        return graph.vertices.sortedInLocalizedStandard()
    }
    
    private func sortedEdges() -> [Edge<String>] {
        return graph.sortedEdgesInLocalizedStandard()
    }
    
    private func sortedEdges(_ edges: [Edge<String>]) -> [Edge<String>] {
        return graph.sortedEdgesInLocalizedStandard(edges)
    }
    
    private func sortedDesc(_ edges: [Edge<String>]) -> [TransitionDescription] {
        let ts = edges.flatMap { (e) -> [TransitionDescription] in
            return self.graph.transitionDesc(e)
        }
        return ts.sortedInLocalizedStandard()
    }
    
    private func sortedDesc(_ edge: Edge<String>) -> [TransitionDescription] {
        return sortedDesc([edge])
    }
}
