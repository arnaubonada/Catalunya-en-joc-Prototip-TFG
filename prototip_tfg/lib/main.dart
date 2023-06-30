import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototip_tfg/blocs/blocs.dart';
import 'package:prototip_tfg/screens/marker_screen.dart';

import 'package:prototip_tfg/screens/screens.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(create: (context) => PlayerBloc()),
      BlocProvider(
          create: (context) => MapBloc(
              locationBloc: BlocProvider.of<LocationBloc>(context),
              context: context))
    ],
    child: const MapsApp(),
  ));
}

class MapsApp extends StatelessWidget {
  const MapsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapsApp',
      initialRoute: 'loading',
      routes: {
        'inventory': (context) => const InventoryScreen(),
        'loading': (context) => const LoadingScreen(),
        'map': (context) => const MapScreen(),
        'marker': (context) => const MarkerScreen(),
        'profile': (context) => const PlayerProfileScreen(),
        'shop': (context) => ShopScreen(),
      },
    );
  }
}
