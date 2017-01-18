// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Flutter/Flutter.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoController : NSObject <FlutterMessageListener>

@property(strong, nonatomic) FlutterViewController *controller;
@property(strong, nonatomic) AVPlayer *player;

@end
