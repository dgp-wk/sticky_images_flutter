import 'package:flutter/material.dart';

typedef OnScalingCallback = void Function(BoxFit);

class ScalingWidgetState extends State<ScalingWidget>
{
  BoxFit fittingMode = BoxFit.cover;
  String message = "Image Fit\nCover";

  void onPressed() async
  {
    setState(()
    {
      switch(fittingMode)
      {
        case BoxFit.fill:
          fittingMode = BoxFit.cover;
          message = "Image Fit\nCover";
          break;
        case BoxFit.cover:
          fittingMode = BoxFit.fill;
          message = "Image Fit\nStretch";
          break;
        // We only want two fill modes. In the event of a cosmic mishap, sanitize everything else to cover.
        case BoxFit.contain:
        case BoxFit.fitHeight:
        case BoxFit.fitWidth:
        case BoxFit.none:
        case BoxFit.scaleDown:
          fittingMode = BoxFit.cover;
          message = "Image Fit\nCover";
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
        icon: const Icon(Icons.fit_screen),
        label: Text(message));
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