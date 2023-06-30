import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototip_tfg/blocs/blocs.dart';
import 'package:prototip_tfg/widgets/widgets.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Inventari', textAlign: TextAlign.center),
          backgroundColor: const Color.fromARGB(255, 185, 100, 30),
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 185, 100, 30),
              Color.fromARGB(255, 200, 150, 100),
              Color.fromARGB(255, 190, 155, 130)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child:
                BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      ]),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(16.0),
                      children: playerBloc.state.items.map((item) {
                        return GestureDetector(
                          onTap: () {
                            playerBloc.add(OnChangeAvatarEvent(item.image));
                          },
                          child: Card(
                            color: const Color.fromARGB(155, 140, 80, 50),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(children: [
                                CircleAvatar(
                                    radius: 80,
                                    backgroundImage: AssetImage(
                                        'assets/img/avatar${item.image}.jpg')),
                                if (playerBloc.state.avatar == item.image)
                                  const CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        Icons.account_circle,
                                        size: 28,
                                        color: Colors.white,
                                      ))
                              ]),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            })));
  }
}
