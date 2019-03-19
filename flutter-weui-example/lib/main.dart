import 'package:flutter/material.dart';
import './views/index.dart';
import './router/index.dart';
import 'package:weui/weui.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State {
  bool isDefaultTheme = true;

  void toggleTheme() {
    this.setState(() {
      isDefaultTheme = !isDefaultTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WeUi(
      theme: isDefaultTheme ? WeTheme() : WeTheme(
        primaryColor: Color(0xff1989fa),
        primaryColorDisabled: Color(0xff5cadff),
        warnColor: Color(0xfffb4343),
        warnColorDisabled: Color(0xfffaa7a3)
      ),
      config: WeConfig(
        toastInfoDuration: 1000
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: Index(this.toggleTheme)
      )
    );
  }
}
