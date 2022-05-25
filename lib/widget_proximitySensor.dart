import 'dart:developer' as developer;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:proximity_sensor/proximity_sensor.dart';

typedef OnUseProximitySensorCallback = void Function(bool);

class ProximityListenerWidget extends StatefulWidget {
  const ProximityListenerWidget({Key? key}) : super(key: key);

  @override
  ProximityListenerWidgetState createState() => ProximityListenerWidgetState();
}


class ProximityListenerWidgetState extends State<ProximityListenerWidget> {
  bool _isNear = false;
  bool _isActive = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    developer.log("Disposing");
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;

        developer.log("Prox Sensor Event: isnear = $_isNear");

        if (_isNear)
        {
            _isActive = true;
            Navigator.of(context).push(PageRouteBuilder(
                opaque: true,
                pageBuilder: (BuildContext context, _, __) =>
                    const BlackoutWidget()));
        }
        else if (_isActive)
        {
          Navigator.pop(context);
          _isActive = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return const SizedBox.shrink();
  }
}

class BlackoutWidget extends StatelessWidget
{
  const BlackoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return const Scaffold(
      backgroundColor: Colors.black
    );
  }
  
}

class ProximitySensorSelectorWidgetState extends State<ProximitySensorSelectorWidget>
{
  bool useProximitySensor = false;
  String message = "Proximity Sensor\nOff";

  void onPressed() async
  {
    setState(()
    {
      useProximitySensor = !useProximitySensor;
      message = "Proximity Sensor\n${useProximitySensor? "On" : "Off"}";
    });
    widget.useProximitySensorCallback(useProximitySensor);
  }

  @override
  Widget build(BuildContext context)
  {
    return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: const Icon(Icons.edgesensor_high),
        label: Text(message));
  }

}
class ProximitySensorSelectorWidget extends StatefulWidget
{
  const ProximitySensorSelectorWidget({
    Key? key,
    required this.useProximitySensorCallback
  }) : super(key: key);

  final OnUseProximitySensorCallback useProximitySensorCallback;

  @override
  State<StatefulWidget> createState() {
    return ProximitySensorSelectorWidgetState();
  }

}