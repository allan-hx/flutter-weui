import 'package:flutter/material.dart';
import './views/index.dart';
import './router/index.dart';
import 'package:weui/weui.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeUi(
      theme: Wetheme(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: Index()
      )
    );
  }
}
