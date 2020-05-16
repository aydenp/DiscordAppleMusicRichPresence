//
//  NowPlayingManager.swift
//  AppleMusicRPC
//
//  Created by Ayden Panhuyzen on 2020-05-16.
//  Copyright © 2020 Ayden Panhuyzen. All rights reserved.
//

import Foundation
import SwordRPC

class NowPlayingManager {
    static let shared = NowPlayingManager()
    let rpc = SwordRPC(appId: "711031191112908851", autoRegister: false)
    
    private init() {
        rpc.delegate = self
    }
    
    @objc func setup() {
        guard !rpc.isConnected else { return }
        rpc.connect()
    }
    
    @objc private func updateState() {
        let item = NowPlaying.current
        
        StatusItemManager.shared.iconState = .from(isPaused: item?.isPaused)
        
        let presence = getPresence(forItem: item)
        rpc.setPresence(presence)
    }
    
    private var timer: Timer? {
        didSet { oldValue?.invalidate() }
    }
    
    func getPresence(forItem item: NowPlaying?) -> RichPresence? {
        guard let item = item else { return nil }
        
        var presence = RichPresence()
        
        presence.details = item.title
        let playbackStateText = item.isPaused ? "Paused" : "Playing"
        
        let trackInfoSecondaryLineItems = [item.artist, item.album].lazy
                            .compactMap({ $0 })
                            .filter({ !$0.isEmpty })
        
        presence.state =  trackInfoSecondaryLineItems.isEmpty ? playbackStateText : trackInfoSecondaryLineItems.joined(separator: " — ")
        
        if !item.isPaused {
            presence.timestamps.start = item.startDate
        }
        
        presence.assets.largeImage = "music"
        presence.assets.largeText = "Music app"
        
        presence.assets.smallImage = item.isPaused ? "paused" : "playing"
        presence.assets.smallText = playbackStateText
        
        return presence
    }
}

extension NowPlayingManager: SwordRPCDelegate {
    func swordRPCDidConnect(_ rpc: SwordRPC) {
        print("Connected to Discord!")
        DispatchQueue.main.async {
            StatusItemManager.shared.isConnectedToDiscord = true
            self.updateState()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateState), userInfo: nil, repeats: true)
        }
    }
    
    func swordRPCDidDisconnect(_ rpc: SwordRPC, code: Int?, message msg: String?) {
        print("Lost Discord connection :(")
        DispatchQueue.main.async {
            StatusItemManager.shared.isConnectedToDiscord = false
            self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.setup), userInfo: nil, repeats: true)
            self.setup()
        }
    }
}
