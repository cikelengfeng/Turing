//
//  ProcessonFileReader.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/9/12.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

private let ProcessonStateTypeName = "umlState"
private let ProcessonEndTypeName = "umlEnd"
private let ProcessonStartTypeName = "umlStart"
private let ProcessonLinkerTypeName = "linker"

struct ProcessonState {
    let id: String
    let content: String
    
    let name: String
    let comment: String?
    
    init?(id: String, content: String) {
        self.id = id
        self.content = content
        let parts = content.split(separator: "\n", maxSplits: 2, omittingEmptySubsequences: true)
        guard parts.count >= 1 else {
            return nil
        }
        name = String(parts[0])
        if parts.count == 2 {
            comment = String(parts[1])
        } else {
            comment = nil
        }
    }
}

struct ProcessonStart {
    let id: String
    let content: String?
}

struct ProcessonLinker {
    let id: String
    let content: String
    let fromStateId: String
    let toStateId: String
    
    let transition: ProcessonTransition
    
    init?(id: String, content: String, fromStateId: String, toStateId: String) {
        self.id = id
        self.content = content
        self.fromStateId = fromStateId
        self.toStateId = toStateId
        
        guard let t = ProcessonTransition(linkerContent: content) else {
            return nil
        }
        self.transition = t
    }
}

struct ProcessonStartLinker {
    let id: String
    let content: String
    let fromStateId: String
    let toStateId: String
}

struct ProcessonTransition {
    let name: String
    let params: [ProcessonParameter]
    
    init?(linkerContent: String) {
        let parts = linkerContent.split(separator: "\n")
        guard parts.count >= 1 else {
            return nil
        }
        name = String(parts[0])
        var ps: [ProcessonParameter] = []
        if parts.count > 1 {
            for paramStr in parts[0..<parts.count] {
                let nameAndType = paramStr.split(separator: ":")
                if nameAndType.count < 2 {
                    continue
                }
                let p = ProcessonParameter(name: String(nameAndType[0]), type: String(nameAndType[1]))
                ps.append(p)
            }
        }
        params = ps
    }
}

extension ProcessonTransition {
    func asTransitionDescription() -> TransitionDescription {
        //目前先不支持参数了
//        let p = params.map { (pp) -> ParameterDescription in
//            return ParameterDescription(name: pp.name, type: pp.type)
//        }
        let t = TransitionDescription(name: name, param: [])
        return t
    }
}

struct ProcessonParameter {
    let name: String
    let type: String
}

struct ProcessonDiagramMeta {
    let id: String
    let title: String
}

class ProcessonFileReader {
    
    private let filePath: String
    private var states: [String: ProcessonState]
    private var linkers: [ProcessonLinker]
    private var start: ProcessonStart!
    private var startLinker: ProcessonStartLinker!
    
    public private(set) var initialVertex: Vertex<String>!
    
    init(filePath: String) {
        self.filePath = filePath
        states = [:]
        linkers = []
        startLinker = nil
        start = nil
        initialVertex = nil
    }
    
    private func getData() -> Data {
        guard let data = FileManager.default.contents(atPath: self.filePath) else {
            fatalError("can not read data from" + self.filePath)
        }
        return data
    }
    
    private func getJSONDict() -> [String: Any] {
        let data = getData()
        let dict: [String: Any]?
        do {
            dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch let error {
            fatalError("can not read json from" + self.filePath + "error is" + error.localizedDescription)
        }
        guard let d = dict else {
            fatalError("can not read json from" + self.filePath)
        }
        return d
    }
    
    private func filterStartLinker(elementsDict: [String: Any], start: ProcessonStart) -> ProcessonStartLinker? {
        var l:ProcessonStartLinker?
        elementsDict.forEach { (kv) in
            guard let elementDict = kv.value as? [String: Any] else {
                return
            }
            guard let type = elementDict["name"] as? String else {
                return
            }
            
            guard type == ProcessonLinkerTypeName else {
                return
            }
            guard let text = elementDict["text"] as? String else {
                return
            }
            guard let from = elementDict["from"] as? [String: Any],
                let fromId = from["id"] as? String
                else {
                    return
            }
            guard let to = elementDict["to"] as? [String: Any],
                let toId = to["id"] as? String
                else {
                    return
            }
            guard let id = elementDict["id"] as? String else {
                return
            }
            guard fromId == start.id else {
                return
            }
            l = ProcessonStartLinker(id: id, content: text, fromStateId: fromId, toStateId: toId)
        }
        return l

    }
    
    private func filterStart(elementsDict: [String: Any]) -> ProcessonStart? {
        var s: ProcessonStart?
        elementsDict.forEach { (kv) in
            guard let elementDict = kv.value as? [String: Any] else {
                return
            }
            guard let type = elementDict["name"] as? String else {
                return
            }
            
            guard type == ProcessonStartTypeName else {
                return
            }
            guard let id = elementDict["id"] as? String else {
                return
            }
            guard let textBlock = elementDict["textBlock"] as? [[String: Any]] else {
                return
            }
            let text: String?
            if textBlock.isEmpty {
                text = nil
            } else {
                text = textBlock[0]["text"] as? String
            }
            s = ProcessonStart(id: id, content: text)
        }
        return s
    }
    
    private func filterLinker(elementsDict: [String: Any], start: ProcessonStart) -> [ProcessonLinker] {
        var l:[ProcessonLinker] = []
        elementsDict.forEach { (kv) in
            guard let elementDict = kv.value as? [String: Any] else {
                return
            }
            guard let type = elementDict["name"] as? String else {
                return
            }
            
            guard type == ProcessonLinkerTypeName else {
                return
            }
            guard let text = elementDict["text"] as? String else {
                return
            }
            guard let from = elementDict["from"] as? [String: Any],
                let fromId = from["id"] as? String
                else {
                    return
            }
            guard let to = elementDict["to"] as? [String: Any],
                let toId = to["id"] as? String
                else {
                    return
            }
            guard let id = elementDict["id"] as? String else {
                return
            }
            guard fromId != start.id else {
                return
            }
            guard let linker = ProcessonLinker(id: id, content: text, fromStateId: fromId, toStateId: toId) else {
                return
            }
            l.append(linker)
        }
        return l
    }
    
    private func filterStates(elementsDict: [String: Any]) -> [String: ProcessonState] {
        var s:[String: ProcessonState] = [:]
        elementsDict.forEach { (kv) in
            guard let elementDict = kv.value as? [String: Any] else {
                return
            }
            guard let type = elementDict["name"] as? String else {
                return
            }
            switch type {
            case ProcessonStateTypeName:
                guard let textBlock = elementDict["textBlock"] as? [[String: Any]] else {
                    return
                }
                guard !textBlock.isEmpty else {
                    return
                }
                guard let text: String = textBlock[0]["text"] as? String else {
                    return
                }
                guard let id = elementDict["id"] as? String else {
                    return
                }
                guard let state = ProcessonState(id: id, content: text) else {
                    return
                }
                s[state.id] = state
            case ProcessonEndTypeName:
                guard let id = elementDict["id"] as? String else {
                    return
                }
                guard let state = ProcessonState(id: id, content: "Finish") else {
                    return
                }
                s[state.id] = state
            default:break
            }
        }
        return s
    }
    
    func getGraph() -> AbstractGraph<String> {
        let dict = getJSONDict()
        guard
            let diagramDict = dict["diagram"] as? [String: Any],
            let outerElementsDict = diagramDict["elements"] as? [String: Any],
            let innerElementsDict = outerElementsDict["elements"] as? [String: Any]
            else {
            fatalError("can not get elements from this processon file!!")
        }
        
        states = filterStates(elementsDict: innerElementsDict)
        guard let s = filterStart(elementsDict: innerElementsDict) else {
            fatalError("start state is missing!!")
        }
        start = s
        linkers = filterLinker(elementsDict: innerElementsDict, start: start)
        guard let sl = filterStartLinker(elementsDict: innerElementsDict, start: start) else {
            fatalError("start linker is missing!!")
        }
        startLinker = sl
        guard !states.isEmpty else {
            fatalError("there is no states!!")
        }
        guard !linkers.isEmpty else {
            fatalError("there is no linkers!!")
        }
        let graph = AdjacencyMatrixGraph<String>()
        var vertex: [String: Vertex<String>] = [:]
        
        states.forEach { (s) in
            let v = graph.createVertex(s.value.name)
            vertex[s.key] = v
        }
        guard let initial = vertex[startLinker.toStateId] else {
            fatalError("initial state is missing")
        }
        initialVertex = initial
        linkers.forEach { (l) in
            let fv = vertex[l.fromStateId]!
            let tv = vertex[l.toStateId]!
            graph.addDirectedEdge(fv, to: tv, withWeight: 1, desc: l.transition.asTransitionDescription())
        }
        return graph
    }
}
