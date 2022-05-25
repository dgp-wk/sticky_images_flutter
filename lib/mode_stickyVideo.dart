import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'widget_proximitySensor.dart';

class StickyVideoWidget extends StatefulWidget
{
  final String videoURI;
  final BoxFit fittingMode;
  final ProximityListenerWidget? proximityListenerWidget;

  const StickyVideoWidget(
      this.videoURI,
      this.fittingMode,
      {
        this.proximityListenerWidget,
        super.key
      });

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
  Widget build(BuildContext context)
  {
    List<Widget> widgets = <Widget>[];
    if (widget.proximityListenerWidget != null)
    {
      widgets.add(widget.proximityListenerWidget!);
    }

    widgets.add(FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return SizedBox.expand(
            child: FittedBox(
                fit:widget.fittingMode,
                clipBehavior: Clip.hardEdge,
                child:SizedBox(
                    width:_controller.value.size.width,
                    height:_controller.value.size.height,
                    child: VideoPlayer(_controller)
              )),
          )
          ;
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));

    return MaterialApp(
        home:WillPopScope(
          onWillPop: () async
            {
              return false;
            },
          child:Stack(
            children: widgets,
        )));
  }
}