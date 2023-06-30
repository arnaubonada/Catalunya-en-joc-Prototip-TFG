import 'package:flutter/material.dart';

class DockButton extends StatelessWidget {
  const DockButton({
    super.key,
    required this.size,
    required this.iconData,
    required this.value,
  });

  final Size size;
  final IconData iconData;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 160, 110, 70),
        width: size.width / 2,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(iconData), Text(value)],
        ));
  }
}
