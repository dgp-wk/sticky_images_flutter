import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sticky_images_flutter/widget_kiosk.dart';

import 'widget_aggressiveFullscreen.dart';
import 'widget_proximitySensor.dart';
import 'widget_scalingMode.dart';
import 'widget_wakelock.dart';

typedef OnPickerCallback = void Function(XFile, bool);

class SelectionWidget extends StatelessWidget
{
  const SelectionWidget({
    Key? key,
    required this.onPickerCallback,
    required this.scalingCallback,
    required this.useProximitySensorCallback,
    required this.useKioskModeCallback,
    required this.useWakelockModeCallback,
    required this.useAggressiveFullscreenCallback,
  }) : super(key: key);

  final OnPickerCallback? onPickerCallback;
  final OnScalingCallback scalingCallback;
  final OnUseProximitySensorCallback useProximitySensorCallback;
  final OnUseKioskModeCallback useKioskModeCallback;
  final OnUseWakelockModeCallback useWakelockModeCallback;
  final OnUseAggressiveFullscreenCallback useAggressiveFullscreenCallback;

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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    const Spacer()
                    ,
                    Flexible(
                        flex: 2,
                        child: SizedBox(
                            height: 150,
                            width: 150,
                            child: FittedBox(
                                child: FloatingActionButton(
                                    onPressed: getImage,
                                    child: const Icon(Icons.insert_photo))))),
                    Flexible(
                        flex: 2,
                        child: SizedBox(
                            height: 150,
                            width: 150,
                            child: FittedBox(
                                child: FloatingActionButton(
                                    onPressed: getVideo,
                                    child: const Icon(Icons.video_file))))),
                    Flexible(
                        flex: 1,
                        child: ScalingWidget(scalingCallback: scalingCallback)
                        ),
                    Flexible(
                        flex: 1,
                        child: KioskSelectorWidget(useKioskModeCallback: useKioskModeCallback)
                    ),
                    Flexible(
                        flex: 1,
                        child: WakelockSelectorWidget(useWakelockModeCallback: useWakelockModeCallback)
                    ),
                    Flexible(
                        flex: 1,
                        child: ProximitySensorSelectorWidget(useProximitySensorCallback: useProximitySensorCallback)
                    ),
                    Flexible(
                        flex: 1,
                        child: AggressiveFullscreenSelectorWidget(useAggressiveFullscreenCallback: useAggressiveFullscreenCallback)
                    ),
                    const Spacer()
                  ]
              ),
            )));
  }
}

