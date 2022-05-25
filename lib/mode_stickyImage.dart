import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:sticky_images_flutter/widget_proximitySensor.dart';

class StickyImageWidgetState extends State<StickyImageWidget> {


  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = <Widget>[];

    widgets.add(Image.file(
      File(widget.imageURI),
      fit: widget.fittingMode,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ));


    developer.log("Nullcheck on Prox Listener: ${widget.proximityListenerWidget}");

    if (widget.proximityListenerWidget != null)
    {
      widgets.add(widget.proximityListenerWidget!);
    }
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

class StickyImageWidget extends StatefulWidget
{
  final String imageURI;
  final BoxFit fittingMode;
  final ProximityListenerWidget? proximityListenerWidget;

  const StickyImageWidget(
      this.imageURI,
      this.fittingMode,
      {
        this.proximityListenerWidget,
        super.key
      });

  @override
  State<StatefulWidget> createState()
  {
    return StickyImageWidgetState();
  }
}