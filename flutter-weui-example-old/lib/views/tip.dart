import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';

class TipPage extends StatefulWidget {
  @override
  SwipePageState createState() => SwipePageState();
}

class SwipePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Sample(
      'WeTip',
      describe: '提示气泡框',
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
            child: WeTip(
              content: Text('这是一个 tip'),
              child: WeBadge(
                child: 'top',
              )
            )
          ),
          SizedBox(
            height: 50,
            child: WeTip(
              placement: WeTipPlacement.right,
              content: Text('这是一个tip'),
              child: WeBadge(
                child: 'right',
              )
            )
          ),
          SizedBox(
            // height: 50,
            child: WeTip(
              placement: WeTipPlacement.bottom,
              content: Text('这是一个 tip'),
              child: WeBadge(
                child: 'bottom',
              )
            )
          ),
          SizedBox(
            height: 50,
            child: WeTip(
              placement: WeTipPlacement.left,
              content: Text('这是一个 tip'),
              child: WeBadge(
                child: 'left',
              )
            )
          )
        ]
      )
    );
  }
}
