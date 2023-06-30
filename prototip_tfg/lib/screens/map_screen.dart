import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:prototip_tfg/blocs/blocs.dart';
import 'package:prototip_tfg/views/views.dart';
import 'package:prototip_tfg/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation == null) {
            return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 185, 100, 30),
                  Color.fromARGB(255, 200, 150, 100),
                  Color.fromARGB(255, 190, 155, 130)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: const Center(child: Text('Carregant...')));
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      markers: mapState.markers.values.toSet(),
                      circles: {
                        Circle(
                          circleId: const CircleId('location'),
                          center: LatLng(
                              locationState.lastKnownLocation!.latitude,
                              locationState.lastKnownLocation!.longitude),
                          radius: 200,
                          fillColor: Colors.blue.shade100.withOpacity(0.5),
                          strokeColor: Colors.blue.shade100.withOpacity(0.2),
                        ),
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: BlocBuilder<PlayerBloc, PlayerState>(
                          builder: (context, state) {
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CoinCounter(
                                      iconData: Icons.monetization_on_rounded,
                                      color: Colors.green[400],
                                      value: state.money.toString()),
                                  CoinCounter(
                                      iconData: Icons.star_rounded,
                                      color: Colors.yellow[700],
                                      value: state.stars.toString()),
                                  CoinCounter(
                                      iconData: Icons.diamond_rounded,
                                      color: Colors.pink[400],
                                      value: state.diamonds.toString()),
                                ]);
                          },
                        )),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, 'inventory'),
                              child: DockButton(
                                  size: size,
                                  iconData: Icons.redeem_rounded,
                                  value: 'Inventari'),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, 'shop'),
                              child: DockButton(
                                  size: size,
                                  iconData: Icons.shopping_cart_rounded,
                                  value: 'Botiga'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton:
          BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
        return GestureDetector(
            child: Stack(children: [
              CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/img/avatar${state.avatar}.jpg')),
              CircleAvatar(
                radius: 13,
                backgroundColor: Colors.white,
                child: Text('${state.level}',
                    style: const TextStyle(color: Colors.black)),
              )
            ]),
            onTap: () => Navigator.pushNamed(context, 'profile'));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
