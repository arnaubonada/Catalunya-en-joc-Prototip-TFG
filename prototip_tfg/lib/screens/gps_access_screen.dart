import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prototip_tfg/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 187, 99, 27),
            Color.fromARGB(255, 201, 146, 102),
            Color.fromARGB(255, 187, 154, 124)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Center(child: BlocBuilder<GpsBloc, GpsState>(
            builder: (context, state) {
              return !state.isGpsEnabled
                  ? const _EnableGpsMessage()
                  : const _AccessButton();
            },
          )
              //  _AccessButton(),
              //  child: _EnableGpsMessage()
              )),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on, size: 100),
        const SizedBox(height: 50),
        const Text(
            'Activa els permisos per utilitzar la ubicació en aquesta aplicació',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center),
        const SizedBox(height: 30),
        MaterialButton(
            color: Colors.black,
            shape: const StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              gpsBloc.askGpsAccess();
            },
            child: const Text('Sol·licitar Accés',
                style: TextStyle(color: Colors.white, fontSize: 16)))
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, size: 100),
        SizedBox(height: 50),
        Text('Per fer servir l\'aplicació, és necessari activar la ubicació',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center),
        SizedBox(height: 100),
      ],
    );
  }
}
