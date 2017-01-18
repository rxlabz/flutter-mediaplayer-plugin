// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "AppDelegate.h"

#import <Flutter/Flutter.h>
#import "VideoController.h"
#import "VideoEmbedder.h"

@implementation AppDelegate {
    VideoController* _videoController;
    VideoEmbedder* _videoEmbedder;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    FlutterDartProject* project = [[FlutterDartProject alloc] initFromDefaultSourceForConfiguration];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    FlutterViewController* flutterController = [[FlutterViewController alloc] initWithProject:project
                                                                                      nibName:nil
                                                                                       bundle:nil];

    /// listen to 'playVideo', 'stopVideo' PlatformMessages
    _videoEmbedder = [[VideoEmbedder alloc] init];
    [flutterController addMessageListener:_videoEmbedder];
    _videoEmbedder.controller = flutterController;

    /// listen to 'openVideoActivity' PlatformMessage
    _videoController = [[VideoController alloc] init];
    [flutterController addMessageListener:_videoController];
    _videoController.controller = flutterController;

    self.window.rootViewController = flutterController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
