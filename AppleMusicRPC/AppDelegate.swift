//
//  AppDelegate.swift
//  AppleMusicRPC
//
//  Created by Ayden Panhuyzen on 2020-05-15.
//  Copyright © 2020 Ayden Panhuyzen. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        StatusItemManager.shared.setup()
        NowPlayingManager.shared.setup()
    }
}
