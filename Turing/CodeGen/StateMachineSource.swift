//
//  StateMachineSource.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/9/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

protocol StateMachineSource {
    var graph: AbstractGraph<String> {get}
    var codePath: String {get}
    var name: String {get}
    var initialVertex: Vertex<String> {get}
}
