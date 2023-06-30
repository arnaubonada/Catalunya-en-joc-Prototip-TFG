import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototip_tfg/blocs/blocs.dart';
import 'package:prototip_tfg/helpers/helpers.dart';
import 'package:prototip_tfg/models/models.dart';
import 'package:prototip_tfg/widgets/widgets.dart';

class ShopScreen extends StatelessWidget {
  final List<Item> items = [
    const Item(currency: 'diamond', image: 2, price: 5),
    const Item(currency: 'money', image: 3, price: 20),
    const Item(currency: 'star', image: 4, price: 1),
    const Item(currency: 'diamond', image: 5, price: 15),
    const Item(currency: 'star', image: 6, price: 3),
    const Item(currency: 'money', image: 7, price: 100),
  ];

  ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Botiga', textAlign: TextAlign.center),
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
                      children: items.map((item) {
                        return GestureDetector(
                          onTap: () {
                            state.items.contains(item)
                                ? null
                                : _hasMoney(item, state)
                                    ? showNoMoneyMessage(context)
                                    : showConfirmBuyMessage(context, item);
                          },
                          child: Card(
                            color: state.items.contains(item)
                                ? const Color.fromARGB(104, 175, 175, 175)
                                : const Color.fromARGB(155, 140, 80, 50),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: AssetImage(
                                            'assets/img/avatar${item.image}.jpg')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: state.items.contains(item)
                                        ? const Text('Comprat',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              item.currency == 'diamond'
                                                  ? Icon(
                                                      Icons.diamond_rounded,
                                                      color: Colors.pink[400],
                                                    )
                                                  : item.currency == 'star'
                                                      ? Icon(
                                                          Icons.star_rounded,
                                                          color: Colors
                                                              .yellow[700],
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .monetization_on_rounded,
                                                          color:
                                                              Colors.green[400],
                                                        ),
                                              const SizedBox(width: 5),
                                              Text('${item.price}',
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
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

bool _hasMoney(Item item, PlayerState state) {
  if (item.currency == 'diamond' && item.price > state.diamonds) {
    return true;
  } else if (item.currency == 'money' && item.price > state.money) {
    return true;
  } else if (item.currency == 'star' && item.price > state.stars) {
    return true;
  }
  return false;
}
