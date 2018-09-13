//
//  GraphProtocol.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/8/14.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

extension AbstractGraph {
    func stateName(_ vertex: Vertex<T>) -> String {
        return "\(vertex.data)"
    }
    func transition(_ edge: Edge<T>) -> TransitionDescription {
        return transition(from: edge.from, to: edge.to)
    }
}
