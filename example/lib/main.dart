import 'package:flutter/material.dart';
import 'package:weui/weui.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'weui',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  void onTap() {
    Calculator.addOne(123);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('weui'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
