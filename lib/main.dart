import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiosk_mode/kiosk_mode.dart';
import 'package:sticky_images_flutter/widget_proximitySensor.dart';
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
  BoxFit fittingMode = BoxFit.cover;
  bool useProximitySensor = false;
  bool isVideo = false;
  bool useKioskMode = false;

  //setFile is the only setter that needs to set state.
  // On we assign an image to make sticky, we can then transition to the stick image mode.
  // So, fire a widget rebuild when we set a file.
  void setFile(XFile file, isVideo) async
  {
    developer.log(file.path);
    setState(() {
      stickyFile = file;
      this.isVideo = isVideo;
    });
  }

  void setScaling(BoxFit fittingMode) async
  {
    developer.log("SetScaling $fittingMode");
    this.fittingMode = fittingMode;
  }

  void setProximitySensor(bool useProximitySensor) async
  {
    this.useProximitySensor = useProximitySensor;
  }

  void setKioskMode(bool useKioskMode) async
  {
    this.useKioskMode = useKioskMode;
  }

  void triggerKioskMode() async
  {
    await startKioskMode();
  }

  @override
  Widget build(BuildContext context)
  {
    if (stickyFile == null)
    {
      return SelectionWidget(
          onPickerCallback: setFile,
          scalingCallback: setScaling,
          useProximitySensorCallback: setProximitySensor,
          useKioskModeCallback: setKioskMode,
      ).build(context);
    }

    if (useKioskMode)
    {
      triggerKioskMode();
    }

    if (isVideo)
    {
      return StickyVideoWidget(stickyFile!.path, fittingMode,
          proximityListenerWidget: useProximitySensor? const ProximityListenerWidget() : null);
    }
    else
    {
      return StickyImageWidget(stickyFile!.path, fittingMode,
          proximityListenerWidget: useProximitySensor? const ProximityListenerWidget() : null);
    }
  }

  @override
  void dispose()
  {
    super.dispose();
  }
}