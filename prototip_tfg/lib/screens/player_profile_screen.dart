import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototip_tfg/blocs/blocs.dart';

class PlayerProfileScreen extends StatelessWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Perfil', textAlign: TextAlign.center),
            backgroundColor: const Color.fromARGB(255, 185, 100, 30)),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 185, 100, 30),
            Color.fromARGB(255, 200, 150, 100),
            Color.fromARGB(255, 190, 155, 130)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      'assets/img/avatar${playerBloc.state.avatar}.jpg'),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite_rounded,
                        color: Color.fromARGB(255, 200, 50, 40)),
                    const SizedBox(width: 10),
                    Text(
                      'Nivell: ${playerBloc.state.level}',
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 60.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inventory_rounded),
                    SizedBox(width: 10),
                    Text(
                      'Missions diàries:',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.missions.length,
                      itemBuilder: (context, index) {
                        final mission = state.missions[index];
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(mission.mission),
                              const SizedBox(width: 10, height: 50),
                              mission.completed
                                  ? const Icon(Icons.check_box_outlined)
                                  : const Icon(
                                      Icons.check_box_outline_blank_rounded)
                            ]);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
