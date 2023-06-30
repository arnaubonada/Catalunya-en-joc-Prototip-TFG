import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototip_tfg/blocs/blocs.dart';
import 'package:prototip_tfg/helpers/helpers.dart';
import 'package:prototip_tfg/models/models.dart';
import 'package:prototip_tfg/widgets/widgets.dart';

class MarkerScreen extends StatelessWidget {
  const MarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final marker = ModalRoute.of(context)?.settings.arguments as Markers;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded))
        ],
        centerTitle: true,
        title: Text(
          marker.place,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 185, 100, 30),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 185, 100, 30),
          Color.fromARGB(255, 200, 150, 100),
          Color.fromARGB(255, 190, 155, 130)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(
                            color: const Color.fromARGB(255, 140, 80, 50),
                            width: 6)),
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35.0),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          height: size.height / 3.5,
                          width: size.width / 1.2,
                          placeholder:
                              const AssetImage('assets/img/loading.gif'),
                          image: NetworkImage(marker.img),
                        ),
                      ),
                      if (marker.info != '')
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                showInfoMessage(
                                    context, marker.place, marker.info);
                              },
                              icon: const Icon(Icons.info_rounded,
                                  color: Colors.white)),
                        )
                    ]),
                  ),
                  BlocBuilder<LocationBloc, LocationState>(
                    builder: (context, state) {
                      return (locationBloc.distance(
                                  state.lastKnownLocation!.latitude,
                                  state.lastKnownLocation!.longitude,
                                  marker.lat,
                                  marker.lng) >
                              0.2)
                          ? const Text(
                              'Apropa\'t més per interactuar amb aquesta ubicació',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            )
                          : marker.rewarded
                              ? const Text(
                                  'Ja has aconseguit una recompensa en aquesta ubicació',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                )
                              : RewardButtons(marker: marker);
                    },
                  ),
                  const SizedBox(height: 50)
                ]),
          ),
        ),
      ),
    );
  }
}
