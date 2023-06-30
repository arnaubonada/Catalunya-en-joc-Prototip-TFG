import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:vector_math/vector_math.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;

  LocationBloc() : super(const LocationState()) {
    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastKnownLocation: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation],
      ));
    });
  }

  double distance(double lat1, double lng1, double lat2, double lng2) {
    double earthRadius = 6371;

    double dLat = radians(lat2 - lat1);
    double dLng = radians(lng2 - lng1);

    double sindLat = sin(dLat / 2);
    double sindLng = sin(dLng / 2);

    double a = pow(sindLat, 2) +
        pow(sindLng, 2) * cos(radians(lat1)) * cos(radians(lat2));

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double dist = earthRadius * c;

    return dist;
  }

  void startFollowingUser() {
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude)));
    });
  }

  @override
  Future<void> close() {
    positionStream?.cancel();
    return super.close();
  }
}
