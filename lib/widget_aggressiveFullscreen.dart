import 'package:flutter/material.dart';

typedef OnUseAggressiveFullscreenCallback = void Function(bool);

class AggressiveFullscreenSelectorWidgetState extends State<AggressiveFullscreenSelectorWidget>
{
  bool useAggressiveFullscreen = true;
  String message = "Aggressive Fullscreen \nOff";

  void onPressed() async
  {
    setState(()
    {
      useAggressiveFullscreen = !useAggressiveFullscreen;
      message = "Aggressive Fullscreen\n${useAggressiveFullscreen? "Off" : "On"}";
    });
    widget.useAggressiveFullscreenCallback(useAggressiveFullscreen);
  }

  @override
  Widget build(BuildContext context)
  {
    return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(useAggressiveFullscreen? Icons.fullscreen : Icons.repeat),
        label: Text(message),
        backgroundColor: useAggressiveFullscreen? Colors.blue : Colors.red);
  }

}
class AggressiveFullscreenSelectorWidget extends StatefulWidget
{
  const AggressiveFullscreenSelectorWidget({
    Key? key,
    required this.useAggressiveFullscreenCallback
  }) : super(key: key);

  final OnUseAggressiveFullscreenCallback useAggressiveFullscreenCallback;

  @override
  State<StatefulWidget> createState() {
    return AggressiveFullscreenSelectorWidgetState();
  }

}