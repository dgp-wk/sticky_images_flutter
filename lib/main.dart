import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'mode_select.dart';
import 'mode_stickyImage.dart';
import 'mode_stickyVideo.dart';

void main ()
{
  runApp(const MyApp());
  init();
}

void init() async
{
  Ticker(tick).start();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

void tick(Duration now)
{

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyState createState() {
    return MyState();
  }
}

class MyState extends State<MyApp>
{
  XFile? stickyFile;
  bool isVideo = false;

  void setFile(XFile file, isVideo) async
  {
    developer.log(file.path);
    setState(() {
      stickyFile = file;
      this.isVideo = isVideo;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if (stickyFile == null)
    {
      return SelectionWidget(
          onPickerCallback: setFile
      ).build(context);
    }

    if (isVideo)
    {
      return StickyVideoWidget(stickyFile!.path);
    }
    return StickyImageWidget(stickyFile!.path);
  }

  @override
  void dispose()
  {
    super.dispose();
  }
}