import 'package:flutter/material.dart';

typedef OnUseKioskModeCallback = void Function(bool);

class KioskSelectorWidgetState extends State<KioskSelectorWidget>
{
  bool useKioskMode = false;
  String message = "App Pinning \nOff";

  void onPressed() async
  {
    setState(()
    {
      useKioskMode = !useKioskMode;
      message = "App Pinning\n${useKioskMode? "On" : "Off"}";
    });
    widget.useKioskModeCallback(useKioskMode);
  }

  @override
  Widget build(BuildContext context)
  {
    return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(useKioskMode? Icons.screen_lock_portrait : Icons.app_shortcut),
        label: Text(message),
        backgroundColor: useKioskMode? Colors.green : Colors.blue);
  }

}
class KioskSelectorWidget extends StatefulWidget
{
  const KioskSelectorWidget({
    Key? key,
    required this.useKioskModeCallback
  }) : super(key: key);

  final OnUseKioskModeCallback useKioskModeCallback;

  @override
  State<StatefulWidget> createState() {
    return KioskSelectorWidgetState();
  }

}