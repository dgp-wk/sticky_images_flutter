import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widget_proximitySensor.dart';
import 'widget_scalingMode.dart';

typedef OnPickerCallback = void Function(XFile, bool);

class SelectionWidget extends StatelessWidget
{
  const SelectionWidget({
    Key? key,
    required this.onPickerCallback,
    required this.scalingCallback,
    required this.useProximitySensorCallback,
  }) : super(key: key);

  final OnPickerCallback? onPickerCallback;
  final OnScalingCallback scalingCallback;
  final OnUseProximitySensorCallback useProximitySensorCallback;

  Future<void> getImage() async
  {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image!= null) {
      onPickerCallback!(image, false);
    }
  }

  Future<void> getVideo() async
  {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video!= null) {
      onPickerCallback!(video, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: SizedBox(
                              height: 150,
                              width: 150,
                              child: FittedBox(
                                  child: FloatingActionButton(
                                      onPressed: getImage,
                                      child: const Icon(Icons.insert_photo))))),
                      Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: SizedBox(
                              height: 150,
                              width: 150,
                              child: FittedBox(
                                  child: FloatingActionButton(
                                      onPressed: getVideo,
                                      child: const Icon(Icons.video_file))))),
                      Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: ScalingWidget(scalingCallback: scalingCallback)
                          ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: ProximitySensorSelectorWidget(useProximitySensorCallback: useProximitySensorCallback)
                      )
                    ]
                ))));
  }
}

