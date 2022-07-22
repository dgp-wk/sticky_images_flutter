import 'package:flutter/material.dart';

typedef OnScalingCallback = void Function(BoxFit);

class ScalingWidgetState extends State<ScalingWidget>
{
  BoxFit fittingMode = BoxFit.cover;
  String message = "Image Fit\nCover";
  IconData icon = Icons.aspect_ratio;
  Color color = Colors.blue;

  void onPressed() async
  {
    setState(()
    {
      switch(fittingMode)
      {
        case BoxFit.fill:
          fittingMode = BoxFit.cover;
          message = "Image Fit\nCover";
          icon = Icons.fit_screen;
          color = Colors.blue;
          break;
        case BoxFit.cover:
          fittingMode = BoxFit.fill;
          message = "Image Fit\nStretch";
          icon = Icons.aspect_ratio;
          color = Colors.red;
          break;
        // We only want two fill modes. In the event of a cosmic mishap, sanitize everything else to cover.
        case BoxFit.contain:
        case BoxFit.fitHeight:
        case BoxFit.fitWidth:
        case BoxFit.none:
        case BoxFit.scaleDown:
          fittingMode = BoxFit.cover;
          message = "Image Fit\nCover";
          icon = Icons.fit_screen;
          color = Colors.blue;
          break;
      }
    });
    widget.scalingCallback(fittingMode);
  }

  @override
  Widget build(BuildContext context)
  {


    return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(message),
        backgroundColor: color);
  }

}
class ScalingWidget extends StatefulWidget
{
  const ScalingWidget({
    Key? key,
    required this.scalingCallback
  }) : super(key: key);

  final OnScalingCallback scalingCallback;

  @override
  State<StatefulWidget> createState() {
    return ScalingWidgetState();
  }

}