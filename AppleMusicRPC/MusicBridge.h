//
//  MusicBridge.h
//  AppleMusicRPC
//
//  Created by Ayden Panhuyzen on 2020-05-15.
//  Copyright © 2020 Ayden Panhuyzen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicBridge : NSObject
- (NSDictionary<NSString *, NSObject *> *)currentTrackInfo;
- (BOOL)isPaused;
- (double)playerPosition;
@end

NS_ASSUME_NONNULL_END
