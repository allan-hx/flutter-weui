import 'package:flutter/material.dart';
import './views/index.dart';
import './router/index.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: Index()
    );
  }
}
