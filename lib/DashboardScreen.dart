import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_location/AppUtils.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({Key key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  StreamSubscription<Position> positionStream;
  String latitude;
  String longitude;
  final bloc = LocationBloc();

  @override
  void initState() {
    bloc.getLocation();
    bloc.locationStream.listen((event) {
      setState(() {
        latitude = event.latitude;
        longitude = event.longitude;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Location'),
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.location_searching),
          ),
          Text('$latitude, $longitude')
        ],
      ),
    );
  }
}
