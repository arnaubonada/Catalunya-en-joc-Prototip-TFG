import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototip_tfg/blocs/blocs.dart';
import 'package:prototip_tfg/models/markers_model.dart';

class RewardButtons extends StatelessWidget {
  final Markers marker;
  const RewardButtons({Key? key, required this.marker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'Escull una recompensa:',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 50),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _RewardButton(Icons.favorite_rounded, Colors.red, 1, marker),
          _RewardButton(
              Icons.monetization_on_rounded, Colors.green[400], 25, marker),
        ]),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _RewardButton(Icons.diamond_rounded, Colors.pink[400], 5, marker),
            _RewardButton(Icons.star_rounded, Colors.yellow[700], 1, marker),
          ],
        ),
      ],
    );
  }
}

class _RewardButton extends StatelessWidget {
  final IconData? iconData;
  final Color? color;
  final int value;
  final Markers marker;
  const _RewardButton(this.iconData, this.color, this.value, this.marker);

  @override
  Widget build(BuildContext context) {
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            backgroundColor: const Color.fromARGB(255, 140, 80, 50)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(iconData, color: color, size: 40),
              const SizedBox(height: 10),
              Text(value.toString(), style: const TextStyle(fontSize: 16))
            ],
          ),
        ),
        onPressed: () {
          iconData == Icons.monetization_on_rounded
              ? playerBloc.add(OnAddMoneyEvent(value))
              : iconData == Icons.star_rounded
                  ? playerBloc.add(OnAddStarEvent(value))
                  : iconData == Icons.diamond_rounded
                      ? playerBloc.add(OnAddDiamondEvent(value))
                      : playerBloc.add(OnAddLevelEvent(value));
          marker.rewarded = true;
          playerBloc.add(OnVisitLocationEvent());
          Navigator.pop(context);
        });
  }
}
