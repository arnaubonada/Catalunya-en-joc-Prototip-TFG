import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:prototip_tfg/blocs/blocs.dart';
import 'package:prototip_tfg/models/markers_model.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Marker> markers;
  final Set<Circle> circles;

  const MapView(
      {Key? key,
      required this.initialLocation,
      required this.markers,
      required this.circles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 17, tilt: 60);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          tiltGesturesEnabled: false,
          scrollGesturesEnabled: false,
          buildingsEnabled: false,
          trafficEnabled: false,
          minMaxZoomPreference: const MinMaxZoomPreference(16, 17),
          onMapCreated: (controller) {
            mapBloc.add(OnMapInitialzedEvent(controller));
            _drawAllMarkers(mapBloc, context);
          },
          markers: markers,
          circles: circles),
    );
  }

  Future _drawAllMarkers(MapBloc mapBloc, BuildContext context) async {
    final currentMarkers = Map<String, Marker>.from(mapBloc.state.markers);

    final markers = markersFromJson(
        await rootBundle.loadString("assets/json/markers.json"));

    for (var element in markers) {
      final marker = Marker(
        consumeTapEvents: true,
        markerId: MarkerId(element.id),
        position: LatLng(element.lat, element.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        onTap: () {
          Navigator.pushNamed(context, 'marker', arguments: element);
        },
      );
      currentMarkers[element.id] = marker;
    }

    mapBloc.add(DisplayMarkersEvent(currentMarkers));
  }
}
