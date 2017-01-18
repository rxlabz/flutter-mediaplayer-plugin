// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String kVideoUrl = "http://techslides.com/demos/sample-videos/small.mp4";

const kAudioUrl = "http://www.sample-videos.com/audio/mp3/crowd-cheering.mp3";

class MediaPlayer extends StatefulWidget {
  @override
  _MediaplayerState createState() => new _MediaplayerState();
}

class _MediaplayerState extends State<MediaPlayer> {
  String _platformFeedback = "";

  @override
  Widget build(BuildContext context) {
    return new Material(
        /*type: MaterialType.transparency,*/
        child: new Align(
            alignment: FractionalOffset.bottomCenter,
            child: new Padding(
                padding: const EdgeInsets.all(28.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Row(children: [
                        new RaisedButton(
                            child: new Text('Play Video'), onPressed: _play),
                        new RaisedButton(
                            child: new Text('stop Video'), onPressed: _stop),
                      ], mainAxisAlignment: MainAxisAlignment.center),
                      /*new Text(_platformFeedback),*/
                      new Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: new RaisedButton(
                              child: new Text('open video activity'),
                              onPressed: _openVideoActivity)),
                      new Row( mainAxisAlignment: MainAxisAlignment.center, children: [
                        new RaisedButton(
                            child: new Text('Play Audio'),
                            onPressed: _playAudio),
                        new RaisedButton(
                            child: new Text('stop Audio'),
                            onPressed: _stopAudio)
                      ])
                    ]))));
  }

  Future<Null> _play() async {
    String reply = await PlatformMessages.sendString('playVideo', kVideoUrl);
    final data = JSON.decode(reply) as Map<String, dynamic>;
    updateDuration(data);
    print("playVideo => $reply");
  }

  void updateDuration(data) {
    setState(() {
      _platformFeedback = data.containsKey('duration')
          ? '${data['duration']} sec'
          : 'Duration : undefined';
    });
  }

  Future<Null> _stop() async {
    String reply = await PlatformMessages.sendString('stopVideo', '');
    print("stopVideo => $reply");
  }

  Future<Null> _openVideoActivity() async {
    String reply =
        await PlatformMessages.sendString('openVideoActivity', kVideoUrl);
    print("openVideoActivity => $reply");
  }

  Future<Null> _playAudio() async {
    String reply = await PlatformMessages.sendString('playAudio', kAudioUrl);
    print("playAudio => $reply");
  }

  Future<Null> _stopAudio() async {
    String reply = await PlatformMessages.sendString('stopAudio', '');

    print("stopAudio => $reply");
  }
}

main() async {
  runApp(new MediaPlayer());
}
