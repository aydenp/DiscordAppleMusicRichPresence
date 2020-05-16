//
//  MusicBridge.m
//  AppleMusicRPC
//
//  Created by Ayden Panhuyzen on 2020-05-15.
//  Copyright © 2020 Ayden Panhuyzen. All rights reserved.
//

#import "MusicBridge.h"
#import <ScriptingBridge/ScriptingBridge.h>
#import "MusicAPI.h"

@implementation MusicBridge {
    MusicApplication *app;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        app = [SBApplication applicationWithBundleIdentifier:@"com.apple.Music"] ?: [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    }
    return self;
}

- (NSDictionary<NSString *, NSObject *> *)currentTrackInfo {
    MusicTrack *track = [app currentTrack];
    return track.properties;
}

- (BOOL)isPaused {
    return app.playerState == MusicEPlSPaused;
}

- (double)playerPosition {
    return app.playerPosition;
}

@end
