//
//  CodeGen.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/9/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

protocol CodeGen {
    init(graph: AbstractGraph<String>, codePath: String, name: String, initialVertex: Vertex<String>)
    func gen()
}
