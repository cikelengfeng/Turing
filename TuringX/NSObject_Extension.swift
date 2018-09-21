//
//  NSObject_Extension.swift
//
//  Created by 徐 东 on 2018/9/20.
//Copyright © 2018 dx lab. All rights reserved.
//

import Foundation

extension NSObject {
    class func pluginDidLoad(bundle: Bundle) {
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? NSString
        if appName == "Xcode" {
        	if sharedPlugin == nil {
        		sharedPlugin = TuringX(bundle: bundle)
        	}
        }
    }
}
