//
//  Parameter.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/8/14.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

public struct ParameterDescription: Hashable {
    let name: String
    let type: String
}

public struct TransitionDescription: Hashable {
    let name: String
    let param: [ParameterDescription]
}
