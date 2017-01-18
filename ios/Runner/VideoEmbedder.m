// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "VideoEmbedder.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@implementation VideoEmbedder {
    //CLLocationManager* _locationManager;
}

@synthesize messageName = _messageName;



- (instancetype) init {
    self = [super init];
    if (self){
        self->_messageName = @"playVideo";
        
    }
    return self;
}



- (NSString*)didReceiveString:(NSString*)message {
    
    NSURL *url = [NSURL URLWithString:message ];
    
    //NSURL *url = [NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4" ];
    //AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    
    
     AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
     UIView *myview = [[UIView alloc] init];
     [myview.layer addSublayer:layer];
     [layer setFrame:CGRectMake(0, 100, _controller.view.frame.size.width, _controller.view.frame.size.height / 2)];
     [_controller.view.layer addSublayer:layer];
    
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
