part of 'location_bloc.dart';

class LocationState extends Equatable {
  final LatLng? lastKnownLocation;
  final List<LatLng> myLocationHistory;

  const LocationState({this.lastKnownLocation, myLocationHistory})
      : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith({
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationHistory,
  }) =>
      LocationState(
        lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
        myLocationHistory: myLocationHistory ?? this.myLocationHistory,
      );

  @override
  List<Object?> get props => [lastKnownLocation, myLocationHistory];
}
