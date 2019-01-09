import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:flutter_weui/flutter_weui.dart';
import '../components/title.dart';

class GridPage extends StatefulWidget {
  @override
  GridPageState createState() => GridPageState();
}

class GridPageState extends State {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    [1, 2, 3, 4, 5, 6, 7, 8, 9].forEach((item) {
      children.add(Container(
        height: 80.0,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(WeIcons.loading),
              Text('Grid - $item')
            ]
          )
        )
      ));
    });

    return Sample(
      'Grid',
      describe: '宫格',
      child: Column(
        children: <Widget>[
          TextTitle('九格宫'),
          WeGrid(
            count: 3,
            children: children
          ),
          TextTitle('八格宫'),
          WeGrid(
            count: 4,
            children: children
          ),
          TextTitle('自定义边框'),
          WeGrid(
            border: BorderSide(width: 1.0, color: Colors.red),
            children: children
          )
        ]
      )
    );
  }
}
