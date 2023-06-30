import 'package:flutter/material.dart';

class CoinCounter extends StatelessWidget {
  final IconData? iconData;
  final Color? color;
  final String value;
  const CoinCounter({
    super.key,
    this.iconData,
    this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      width: 80,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(iconData, color: color),
          Text(value),
        ],
      ),
    );
  }
}
