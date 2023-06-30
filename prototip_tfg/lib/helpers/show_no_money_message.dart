import 'package:flutter/material.dart';

void showNoMoneyMessage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            'No tens suficients diners',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('D\'acord'),
          ),
        ],
      );
    },
  );
}
