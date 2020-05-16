//
//  NowPlaying.swift
//  AppleMusicRPC
//
//  Created by Ayden Panhuyzen on 2020-05-15.
//  Copyright © 2020 Ayden Panhuyzen. All rights reserved.
//

import Foundation

struct NowPlaying {
    let id: Int, title: String, artist: String?, album: String?, isPaused: Bool, startDate: Date
    
    private static let bridge = MusicBridge()
    static var current: NowPlaying? {
        let trackInfo = bridge.currentTrackInfo()
        guard let id = trackInfo["id"] as? Int, let title = trackInfo["name"] as? String else { return nil }
        
        let position = bridge.playerPosition()
        
        return NowPlaying(
            id: id, title: title,
            artist: trackInfo["artist"] as? String,
            album: trackInfo["album"] as? String,
            isPaused: bridge.isPaused(),
            startDate: Date() - position)
    }
}
