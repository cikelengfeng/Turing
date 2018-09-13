//
//  main.swift
//  WarMechine
//
//  Created by 徐 东 on 2018/7/29.
//  Copyright © 2018 dx lab. All rights reserved.
//

import Foundation


let manager = SubroutineManager()
let processGen = ProcessonGenSubroutine()
manager.register(processGen)

manager.run()
