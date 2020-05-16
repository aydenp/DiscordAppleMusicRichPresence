//
//  StatusItemManager.swift
//  AppleMusicRPC
//
//  Created by Ayden Panhuyzen on 2020-05-16.
//  Copyright © 2020 Ayden Panhuyzen. All rights reserved.
//

import Cocoa

class StatusItemManager {
    static let shared = StatusItemManager()
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let discordStatusMenuItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
    
    private init() {
        statusItem.button?.title = "Apple Music Discord Status"
        
        let menu = NSMenu()
        menu.addItem(discordStatusMenuItem)
        menu.addItem(.separator())
        menu.addItem(withTitle: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        statusItem.menu = menu
        
        defer {
            isConnectedToDiscord = false
            updateIcon()
        }
    }
    
    func setup() {}
    
    private func updateIcon() {
        statusItem.button?.image = NSImage(named: "StatusItem_\(isConnectedToDiscord ? iconState.imageSuffix : "disabled")")
    }
    
    var isConnectedToDiscord = false {
        didSet {
            discordStatusMenuItem.title = "\(isConnectedToDiscord ? "" : "Not ")Connected to Discord"
            updateIcon()
        }
    }
    
    var iconState = IconPlaybackState.stopped {
        didSet { updateIcon() }
    }
    
    enum IconPlaybackState: String {
        case playing, paused, stopped
        
        var imageSuffix: String {
            return rawValue
        }
        
        static func from(isPaused: Bool?) -> IconPlaybackState {
            guard let isPaused = isPaused else { return .stopped }
            return isPaused ? .paused : .playing
        }
    }
}
