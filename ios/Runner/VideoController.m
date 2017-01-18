// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "VideoController.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@implementation VideoController {
    //CLLocationManager* _locationManager;
}

@synthesize messageName = _messageName;

- (instancetype) init {
    self = [super init];
    if (self){
        self->_messageName = @"openVideoActivity";
    }
    return self;
}

- (NSString*)didReceiveString:(NSString*)message {
    
    NSURL *url = [NSURL URLWithString:message ];

    NSLog(@"message %@", message);

    AVPlayer *player = [AVPlayer playerWithURL:url];

    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.showsPlaybackControls = YES;
    playerViewController.player = player;
    
    [_controller.view addSubview: playerViewController.view];
    [_controller presentViewController:playerViewController animated:YES completion:nil];

    [player play];

    CMTime duration = player.currentItem.asset.duration;
    float durationSec = CMTimeGetSeconds(duration);

    NSDictionary* response = @{
                               @"result": @1,
                               @"duration": [NSNumber numberWithFloat:durationSec]
                               };
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:response options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end
