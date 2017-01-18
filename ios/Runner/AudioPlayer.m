// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "VideoEmbedder.h"
#import "AudioPlayer.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@implementation AudioPlayer {
    AVPlayer *player;
}

@synthesize messageName = _messageName;



- (instancetype) init {
    self = [super init];
    if (self){
        self->_messageName = @"playAudio";
        
    }
    return self;
}



- (NSString*)didReceiveString:(NSString*)message {
    
    NSURL *url = [NSURL URLWithString:message ];
    
    //NSURL *url = [NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4" ];
    //AVPlayer *player = [AVPlayer playerWithPlayerItem:item];

    if( !player )
        player = [AVPlayer playerWithURL:url];

    float durationSec = 0;

    if ((player.rate != 0) && (player.error == nil)) {
        [player pause];

    } else {
        [player play];

        CMTime duration = player.currentItem.asset.duration;
        durationSec = CMTimeGetSeconds(duration);
    }

    NSDictionary* response = @{
            @"result": @1,
            @"duration": [NSNumber numberWithFloat:durationSec]
    };
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:response options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end
