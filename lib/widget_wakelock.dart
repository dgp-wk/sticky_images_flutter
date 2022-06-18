import 'package:flutter/material.dart';

typedef OnUseWakelockModeCallback = void Function(bool);

class WakelockSelectorWidgetState extends State<WakelockSelectorWidget>
{
  bool useWakelockMode = true;
  String message = "Screen Timeout \nOff";

  void onPressed() async
  {
    setState(()
    {
      useWakelockMode = !useWakelockMode;
      message = "Screen Timeout\n${useWakelockMode? "Off" : "On"}";
    });
    widget.useWakelockModeCallback(useWakelockMode);
  }

  @override
  Widget build(BuildContext context)
  {
    return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(useWakelockMode? Icons.lightbulb : Icons.lock_clock),
        label: Text(message),
        backgroundColor: useWakelockMode? Colors.blue : Colors.red);
  }

}
class WakelockSelectorWidget extends StatefulWidget
{
  const WakelockSelectorWidget({
    Key? key,
    required this.useWakelockModeCallback
  }) : super(key: key);

  final OnUseWakelockModeCallback useWakelockModeCallback;

  @override
  State<StatefulWidget> createState() {
    return WakelockSelectorWidgetState();
  }

}