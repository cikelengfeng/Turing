//
//  LibTuringTests.swift
//  LibTuringTests
//
//  Created by 徐 东 on 2018/9/20.
//  Copyright © 2018 dx lab. All rights reserved.
//

import XCTest
import Foundation
@testable import LibTuring


class LibTuringMDTests: XCTestCase {
    
    let gen = MultiDimensionGenSubroutine()
    let outputPath = NSTemporaryDirectory()
    var headerPath: String {
        get {
            return (outputPath as NSString).appendingPathComponent("TestStateMachine.h")
        }
    }
    var implPath: String {
        get {
            return (outputPath as NSString).appendingPathComponent("TestStateMachine.m")
        }
    }
    let bundle = Bundle.init(for: LibTuringMDTests.self)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        gen.run(arguments: [outputPath, "Test", "A", "B", "C", "D"])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        do {
            try FileManager.default.removeItem(atPath: headerPath)
            try FileManager.default.removeItem(atPath: implPath)
        } catch let error {
            print(error)
        }
    }
    
    func testGenCode() {
        guard let comparisonHeaderPath = bundle.path(forResource: "MDTestStateMachineHeader", ofType: "txt")
            else {
                XCTAssert(false, "对比用的头文件丢失")
                return
        }
        guard let comparsionHeaderCode = FileManager.default.contents(atPath: comparisonHeaderPath) else {
            XCTAssert(false, "读取对比用的头文件失败")
            return
        }
        guard let comparisonImplPath = bundle.path(forResource: "MDTestStateMachineImpl", ofType: "txt"),
            let comparsionImplCode = FileManager.default.contents(atPath: comparisonImplPath)
            else {
                XCTAssert(false, "对比用的实现文件丢失")
                return
        }
        
        
        guard
            let headerCode = FileManager.default.contents(atPath: headerPath)
            else {
                XCTAssert(false, "生成的头文件丢失")
                return
        }
        
        guard
            let implCode = FileManager.default.contents(atPath: implPath)
            else {
                XCTAssert(false, "生成的头文件丢失")
                return
        }
        
        XCTAssertEqual(headerCode, comparsionHeaderCode)
        XCTAssertEqual(implCode, comparsionImplCode)
    }
    
}
