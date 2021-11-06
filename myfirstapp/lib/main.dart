import 'package:flutter/material.dart';

import 'myapp.dart';

void main() {
  runApp(MaterialApp(
    title: "Transaction app",
    theme: ThemeData(
        primaryColor: Colors.pink[300], accentColor: Colors.blueAccent),
    home: MyApp(),
  ));
}
