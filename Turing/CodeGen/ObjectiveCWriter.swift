//
//  ObjectiveCWriter.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/14.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

enum ObjectiveCLifeCycleModifier: String {
    case strong = "strong"
    case assign = "assign"
    case weak = "weak"
    case unsafeUnretained = "unsafe_unretained"
}

enum ObjectiveCRWModifier: String {
    case readwrite = "readwrite"
    case readonly = "readonly"
}

enum ObjectiveCSelectorModifier {
    case getter(selector: String)
    case setter(selector: String)
    
    func asString() -> String {
        switch self {
        case .getter(let s):
            return "getter = \(s)"
        case .setter(let s):
            return "setter = \(s)"
        }
    }
}

class ObjectiveCWriter {
    
    private let writer: CodeWriter
    
    init() {
        writer = CodeWriter()
    }
    
    public func setup(filePath: String) {
        writer.setup(filePath)
    }
    
    public func teardown() {
        writer.teardown()
    }
    
    private func code(protocolArr: [String]) -> String {
        return "<" + protocolArr.joined(separator: ",") + ">"
    }
    
    func writeInterface(name: String, superInterface: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@interface \(name): \(code(protocolArr: protocolArr))")
        pushIndent()
        body?(self)
        popIndent()
        writeLine("@end")
    }
    
    func writeInterface(name: String, categoryName: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@interface \(name) (\(categoryName)) \(code(protocolArr: protocolArr))")
        pushIndent()
        body?(self)
        popIndent()
        writeLine("@end")
    }
    
    func writeProperty(lifeCycle: [ObjectiveCLifeCycleModifier], rw: [ObjectiveCRWModifier], selector: [ObjectiveCSelectorModifier], type: String, name: String) {
        let lfs = lifeCycle.map { (m) -> String in
            return m.rawValue
        }.joined(separator: ",")
        let rws = rw.map { (m) -> String in
            return m.rawValue
        }.joined(separator: ",")
        let ss = selector.map { (s) -> String in
            return s.asString()
        }.joined(separator: ",")
        writeLine("@property (\([lfs, rws, ss].joined(separator: ",")) \(type) \(name)")
    }
    
    func writeMethodDeclaration(isClassMethod: Bool, returnType: String?, fragments: [(name: String, param: (type: String, name: String)?)]) {
        let prefix = isClassMethod ? "+" : "-" + " "
        let ret = "(" + (returnType ?? "void") + ")"
        let signatrue = fragments.map { (name, param) -> String in
            if let p = param {
                return name + ":(" + p.type + ")" + p.name
            } else {
                return name
            }
        }.joined(separator: " ")
        writeLine(prefix + ret + signatrue)
    }
    
    func writeEnumDefination(rawType: String, name: String, cases: [String]) {
        writeLine("typedef NS_ENUM(\(rawType), \(name)) {")
        pushIndent()
        cases.forEach { (c) in
            writeLine("\(rawType)\(c);")
        }
        popIndent()
        writeLine("};")
    }
    
    func writeImplementation(name: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@implementation \(name)\(code(protocolArr: protocolArr))")
        pushIndent()
        body?(self)
        popIndent()
        writeLine("@end")
    }
    
    func writeImplementation(name: String, categoryName: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@implementation \(name) (\(categoryName))\(code(protocolArr: protocolArr))")
        pushIndent()
        body?(self)
        popIndent()
        writeLine("@end")
    }
    
    func writeMethodDefination(isClassMethod: Bool, returnType: String?, fragments: [(name: String, param: (type: String, name: String)?)], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        let prefix = isClassMethod ? "+" : "-" + " "
        let ret = "(" + (returnType ?? "void") + ")"
        let signatrue = fragments.map { (name, param) -> String in
            if let p = param {
                return name + ":(" + p.type + ")" + p.name
            } else {
                return name
            }
            }.joined(separator: " ")
        writeLine(prefix + ret + signatrue + " {")
        pushIndent()
        body?(self)
        popIndent()
        writeLine("}")
    }
    
    func writeMethodCall(receiver: String, fragments: [(name: String, body: (_ writer: ObjectiveCWriter) -> ())]) {
        write("[\(receiver) ")
        fragments.forEach { (name, body) in
            write(name + ": ")
            body(self)
        }
        write("]")
    }
    
    func writeMethodCall(receiver: String, fragments: [(name: String, value: String)]) {
        let f = fragments.map { (nv) -> (name: String, body: (_ writer: ObjectiveCWriter) -> ()) in
            return (nv.name, { (w) in
                w.write(nv.value)
            })
        }
        writeMethodCall(receiver: receiver, fragments: f)
    }
    
    func writeDynamicProperty(name: String) {
        writeLine("@dynamic " + name)
    }
    
    func writeDefaultSynthesize(name: String) {
        writeLine("@synthesize " + name + " = _" + name)
    }
}

extension ObjectiveCWriter: Writer {
    func pushIndent() {
        writer.pushIndent()
    }
    
    func popIndent() {
        writer.popIndent()
    }
    
    func write(_ code: String) {
        writer.write(code)
    }
    
    func writeLine(_ code: String) {
        writeLine(code)
    }
}
