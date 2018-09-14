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
        guard !protocolArr.isEmpty else {
            return ""
        }
        return "<" + protocolArr.joined(separator: ",") + ">"
    }
    
    func writeInterface(name: String, superInterface: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@interface \(name): \(superInterface) \(code(protocolArr: protocolArr))")
        body?(self)
        writeLine("@end")
    }
    
    func writeInterface(name: String, categoryName: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@interface \(name) (\(categoryName)) \(code(protocolArr: protocolArr))")
        body?(self)
        writeLine("@end")
    }
    
    func writeProperty(lifeCycle: [ObjectiveCLifeCycleModifier], atomic: Bool, rw: [ObjectiveCRWModifier], selector: [ObjectiveCSelectorModifier], type: String, name: String) {
        let lfs = lifeCycle.map { (m) -> String in
            return m.rawValue
        }.joined(separator: ",")
        let ats = atomic ? "atomic" : "nonatomic"
        let rws = rw.map { (m) -> String in
            return m.rawValue
        }.joined(separator: ",")
        let ss = selector.map { (s) -> String in
            return s.asString()
        }.joined(separator: ",")
        let final = [lfs, ats, rws, ss].filter { (s) -> Bool in
            return !s.isEmpty
        }.joined(separator: ",")
        writeLine("@property (\(final)) \(type) \(name);")
    }
    
    func writeMethodDeclaration(isClassMethod: Bool, returnType: String?, prefix: String, fragments: [(name: String, param: (type: String, name: String)?)]) {
        let methodType = isClassMethod ? "+" : "-" + " "
        let ret = "(" + (returnType ?? "void") + ")"
        let signatrue = fragments.map { (name, param) -> String in
            if let p = param {
                return name + ":(" + p.type + ")" + p.name
            } else {
                return name
            }
        }.joined(separator: " ")
        writeLine(methodType + ret + prefix + signatrue + ";")
    }
    
    func writeEnumDefination(rawType: String, name: String, cases: [String]) {
        writeLine("typedef NS_ENUM(\(rawType), \(name)) {")
        pushIndent()
        cases.forEach { (c) in
            writeLine("\(c),")
        }
        popIndent()
        writeLine("};")
    }
    
    func writeImplementation(name: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@implementation \(name)\(code(protocolArr: protocolArr))")
        body?(self)
        writeLine("@end")
    }
    
    func writeImplementation(name: String, categoryName: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@implementation \(name) (\(categoryName))\(code(protocolArr: protocolArr))")
        body?(self)
        writeLine("@end")
    }
    
    func writeMethodDefination(isClassMethod: Bool, returnType: String?, prefix: String, fragments: [(name: String, param: (type: String, name: String)?)], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        let methodType = isClassMethod ? "+" : "-" + " "
        let ret = "(" + (returnType ?? "void") + ")"
        let signatrue = fragments.map { (name, param) -> String in
            if let p = param {
                return name + ":(" + p.type + ")" + p.name
            } else {
                return name
            }
            }.joined(separator: " ")
        writeLine(methodType + ret + prefix + signatrue + " {")
        body?(self)
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
    
    func writeSharpImport(file: String) {
        writeLine("#import " + file)
    }
    
    func writeForwardClassDeclaration(type: String) {
        writeLine("@class " + type + ";")
    }
    
    func writeProtocolDeclaration(name: String, protocolArr: [String], body: ((_ writer: ObjectiveCWriter) -> ())?) {
        writeLine("@protocol " + name + " " + code(protocolArr: protocolArr))
        body?(self)
        writeLine("@end")
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
        writer.writeLine(code)
    }
}
