import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar(
      {Key? key,
      required String message,
      Duration duration = const Duration(seconds: 2)})
      : super(
          backgroundColor: Colors.brown,
          key: key,
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          duration: duration,
        );
}
