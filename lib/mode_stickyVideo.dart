import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StickyVideoWidget extends StatefulWidget
{
  final String videoURI;
  const StickyVideoWidget(this.videoURI,{super.key});

  @override
  StickyVideoWidgetState createState()
  {
    return StickyVideoWidgetState();
  }
}

class StickyVideoWidgetState extends State<StickyVideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late String videoURI;

  @override
  void initState()
  {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.file(File(widget.videoURI));

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: VideoPlayer(_controller),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}