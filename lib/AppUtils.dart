import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:gps_location/Bloc.dart';

class LocationBloc implements Bloc {
  Location location;
  StreamSubscription<Position> positionStream;

  final _controller = StreamController<Location>();

  Stream<Location> get locationStream => _controller.stream;

  getLocation() {
    positionStream = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.best, timeInterval: 5000)
        .listen((Position position) {
      if (position != null) {
        location = Location(
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString());
        _controller.sink.add(location);
      } else {
        location = Location(latitude: 'Unknown', longitude: 'Unknown');
        _controller.sink.add(location);
      }
    });
  }

  @override
  void dispose() {
    _controller.close();
    positionStream.cancel();
  }
}

class Location {
  String latitude;
  String longitude;
  Location({
    this.latitude,
    this.longitude,
  });
}
