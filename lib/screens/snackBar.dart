import 'package:flutter/material.dart';

void displaySnackBar(BuildContext context, String value) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      value,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    backgroundColor: Theme.of(context).primaryColor,
  ));
}
