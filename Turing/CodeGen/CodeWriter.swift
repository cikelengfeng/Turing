//
//  CodeWriter.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/9/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

protocol Writer {
    func pushIndent()
    func popIndent()
    func writeLine(_ code: String)
    func write(_ code: String)
}

class CodeWriter: Writer {
    var indent: Int = 0
    var fileHandle: FileHandle!
    func setup(_ filePath: String) {
        FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
        fileHandle = FileHandle(forWritingAtPath: filePath)!
    }
    func teardown() {
        fileHandle.closeFile()
    }
    
    func pushIndent() {
        guard indent < 65535 else {
            return
        }
        indent += 1
    }
    func popIndent() {
        guard indent > 0 else {
            return
        }
        indent -= 1
    }
    func writeLine(_ code: String) {
        write(code + "\n")
    }
    func write(_ code: String) {
        guard !code.isEmpty else {
            return
        }
        let indentBlank = Array<String>(repeating: " ", count: indent * 4).joined()
        let str = indentBlank + code
        guard let data = str.data(using: String.Encoding.utf8) else {
            return
        }
        fileHandle.write(data)
    }
}
