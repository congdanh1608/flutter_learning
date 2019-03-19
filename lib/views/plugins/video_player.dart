import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyVideo();
  }
}

class _MyVideo extends State<MyVideo> {
  VideoPlayerController _controller;
  Future<void> _initVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    _initVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FutureBuilder(
          future: _initVideoPlayerFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
            child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ),
        )
      ],
    );
  }
}
