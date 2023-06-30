import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototip_tfg/blocs/blocs.dart';
import 'package:prototip_tfg/models/models.dart';
import 'package:prototip_tfg/ui/ui.dart';

void showConfirmBuyMessage(BuildContext context, Item item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final playerBloc = BlocProvider.of<PlayerBloc>(context);
      return AlertDialog(
        title: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            'Segur que vols comprar aquest objecte?',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel·la', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              item.currency == 'diamond'
                  ? playerBloc.add(OnAddDiamondEvent(-item.price))
                  : item.currency == 'star'
                      ? playerBloc.add(OnAddStarEvent(-item.price))
                      : playerBloc.add(OnAddMoneyEvent(-item.price));
              playerBloc.add(OnBuyItemEvent(item));
              final snack =
                  CustomSnackbar(message: 'Has comprat un nou objecte!');
              ScaffoldMessenger.of(context).showSnackBar(snack);
            },
            child: const Text('Compra'),
          ),
        ],
      );
    },
  );
}
