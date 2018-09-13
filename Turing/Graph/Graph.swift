//
//  Graph.swift
//  Graph
//
//  Created by Andrew McKnight on 5/8/16.
//

import Foundation

open class AbstractGraph<T>: CustomStringConvertible where T: Hashable {

  public required init() {}

  public required init(fromGraph graph: AbstractGraph<T>) {
    for edge in graph.edges {
        let from = createVertex(edge.from.data)
        let to = createVertex(edge.to.data)
        let transition = graph.transition(from: from, to: to)
      addDirectedEdge(from, to: to, withWeight: edge.weight, desc: transition)
    }
  }

  open var description: String {
    fatalError("abstract property accessed")
  }

  open var vertices: [Vertex<T>] {
    fatalError("abstract property accessed")
  }

  open var edges: [Edge<T>] {
    fatalError("abstract property accessed")
  }

  // Adds a new vertex to the matrix.
  // Performance: possibly O(n^2) because of the resizing of the matrix.
    open func createVertex(_ data: T) -> Vertex<T> {
    fatalError("abstract function called")
  }

    open func addDirectedEdge(_ from: Vertex<T>, to: Vertex<T>, withWeight weight: Double?, desc: TransitionDescription) {
        let key = transitionStoreKey(from: from, to: to)
        transitionStore[key] = desc
  }

  open func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
    fatalError("abstract function called")
  }

  open func edgesFrom(_ sourceVertex: Vertex<T>) -> [Edge<T>] {
    fatalError("abstract function called")
  }
    final func transition(from: Vertex<T>, to: Vertex<T>) -> TransitionDescription {
        return transitionStore[transitionStoreKey(from: from, to: to)]!
    }
    
    final func allTransition() -> [TransitionDescription] {
        return transitionStore.values.map({ (t) -> TransitionDescription in
            return t
        })
    }
    
    private func transitionStoreKey(from: Vertex<T>, to: Vertex<T>) -> Int {
        return "\(from.index)_\(to.index)".hashValue
    }
    
    private var paths: [[Vertex<T>]] = []
    private var transitionStore: [Int: TransitionDescription] = [:]
    
    func findPaths(fromVertex: Vertex<T>, toVertex: Vertex<T>) -> [[Vertex<T>]] {
        paths.removeAll()
        findPaths(fromVertex: fromVertex, toVertex: toVertex, edge: nil, stack: [], visited: [])
        return paths
    }
    
    func findPaths(fromVertex: Vertex<T>, toVertex: Vertex<T>, edge: Edge<T>?, stack: [Vertex<T>], visited: Set<Edge<T>>) {
        if fromVertex == toVertex {
            return
        }
        var newStack = stack
        var newVisited = visited
        
        newStack.append(fromVertex)
        if let e = edge {
            newVisited.insert(e)
        }
        for edge in edgesFrom(fromVertex) {
            if edge.to == toVertex {
                paths.append(newStack + [edge.to])
                continue
            }
            if newVisited.contains(edge) {
                continue
            }
            findPaths(fromVertex: edge.to, toVertex: toVertex, edge: edge, stack: newStack, visited: newVisited)
        }
    }
}
