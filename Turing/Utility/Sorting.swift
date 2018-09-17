//
//  Sorting.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/17.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

extension Array where Element == Vertex<String> {
    func sortedInLocalizedStandard() -> Array {
        return self.sorted(by: { (v1, v2) -> Bool in
            return v1.data.localizedStandardCompare(v2.data) == .orderedAscending
        })
    }
}


extension AbstractGraph where T == String {
    
    private func edgeSortingString(_ edge: Edge<T>) -> String {
        return edge.from.data + edge.to.data
    }
    
    func sortedEdgesInLocalizedStandard() -> [Edge<T>] {
        return sortedEdgesInLocalizedStandard(self.edges)
    }
    
    func sortedEdgesInLocalizedStandard(_ edges: [Edge<T>]) -> [Edge<T>] {
        return edges.sorted(by: { (e1, e2) -> Bool in
            return edgeSortingString(e1).localizedStandardCompare(edgeSortingString(e2)) == .orderedAscending
        })
    }
}

extension TransitionDescription {
    func sortingString() -> String {
        return self.name + self.param.map({ (p) -> String in
            return p.name + p.type
        }).joined()
    }
}

extension Array where Element == TransitionDescription {
    func sortedInLocalizedStandard() -> Array {
        return self.sorted(by: { (t1, t2) -> Bool in
            return t1.sortingString().localizedStandardCompare(t2.sortingString()) == .orderedAscending
        })
    }
}

extension Dictionary where Key == TransitionDescription {
    func sortedKeysInLocalizedStandard() -> Array<Key> {
        let arr = Array(self.keys)
        return arr.sorted(by: { (t1, t2) -> Bool in
            return t1.sortingString().localizedStandardCompare(t2.sortingString()) == .orderedAscending
        })
    }
}
