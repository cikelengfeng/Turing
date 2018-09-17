//
//  NameFormat.swift
//  Turing
//
//  Created by 徐 东 on 2018/9/17.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

extension String {
    func upperFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func lowerFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}
