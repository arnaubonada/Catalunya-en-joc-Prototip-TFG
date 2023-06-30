import 'package:flutter/material.dart';

void showInfoMessage(BuildContext context, String title, String description) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            icon: const Icon(Icons.info),
            title: Text(title),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                textAlign: TextAlign.justify,
              ),
            ),
          ));
}
