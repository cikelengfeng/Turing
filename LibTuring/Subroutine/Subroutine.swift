//
//  Subroutine.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

public protocol Subroutine {
    var commandSequence: [String] {get}
    func run(arguments: [String])
}
