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
    func transitionDesc(_ edge: Edge<T>) -> [TransitionDescription] {
        return transitionDesc(from: edge.from, to: edge.to)
    }
    
}

extension TransitionDescription {
    func upperCased() -> TransitionDescription {
        let newParam = self.param.map { (p) -> ParameterDescription in
            let newP = ParameterDescription(name: p.name.upperFirstLetter(), type: p.type)
            return newP
        }
        let ret = TransitionDescription(name: self.name.upperFirstLetter(), param: newParam)
        return ret
    }
}

extension AbstractGraph where T == String {
    func createUpperCasedVertex(_ vertex: Vertex<T>) -> Vertex<T> {
        return createVertex(vertex.data.upperFirstLetter())
    }
}

extension AbstractGraph where T == String {
    func upperCased() -> AbstractGraph {
        let ret = type(of: self).init()
        
        self.vertices.forEach { (v) in
            _ = ret.createUpperCasedVertex(v)
        }
        
        self.edges.forEach { (e) in
            let newFrom = ret.createVertex(e.from.data.upperFirstLetter())
            let newTo = ret.createVertex(e.to.data.upperFirstLetter())
            self.transitionDesc(e).forEach({ (t) in
                let newT = t.upperCased()
                ret.addDirectedEdge(newFrom, to: newTo, withWeight: e.weight, desc: newT)
            })
        }
        
        return ret
    }
}
