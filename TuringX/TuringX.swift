//
//  TuringX.swift
//
//  Created by 徐 东 on 2018/9/20.
//Copyright © 2018 dx lab. All rights reserved.
//

import AppKit

var sharedPlugin: TuringX?

class TuringX: NSObject {

    var bundle: Bundle
    lazy var center = NotificationCenter.default

    init(bundle: Bundle) {
        self.bundle = bundle

        super.init()
        center.addObserver(self, selector: Selector(("createMenuItems")), name: NSApplication.didFinishLaunchingNotification, object: nil)
    }

    deinit {
        removeObserver()
    }

    func removeObserver() {
        center.removeObserver(self)
    }

    func createMenuItems() {
        removeObserver()

        let item = NSApp.mainMenu!.item(withTitle: "Edit")
        if item != nil {
            let actionMenuItem = NSMenuItem(title:"Do Action", action:Selector(("doMenuAction")), keyEquivalent:"")
            actionMenuItem.target = self
            item!.submenu!.addItem(NSMenuItem.separator())
            item!.submenu!.addItem(actionMenuItem)
        }
    }

    func doMenuAction() {
        let error = NSError(domain: "Hello World!", code:42, userInfo:nil)
        NSAlert(error: error).runModal()
    }
}

