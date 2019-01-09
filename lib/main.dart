import 'package:flutter/material.dart';
import './router/index.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App () {
    // 路由初始化
    Routes.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.router.generator
    );
  }
}
