import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';
import '../components/title.dart';
import 'package:weui/theme.dart';

class BadgePage extends StatefulWidget {
  @override
  BadgePageState createState() => BadgePageState();
}

class BadgePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Sample(
      'Badge',
      describe: '徽章',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextTitle('默认', noPadding: true),
          Row(
            children: [
              WeBadge(child: '1'),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: WeBadge(child: 'value')
              )
            ]
          ),
          TextTitle('自定义样式', noPadding: true),
          WeBadge(
            child: 'Value',
            color: primary,
            textStyle: TextStyle(
              fontSize: 14.0
            )
          ),
          TextTitle('边框', noPadding: true),
          WeBadge(
            child: 'Value',
            border: Border.all(width: 1, color: Colors.black)
          ),
          TextTitle('空心', noPadding: true),
          Row(
            children: [
              WeBadge(child: '1', hollow: true),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: WeBadge(child: 'value', hollow: true)
              )
            ]
          ),
        ]
      )
    );
  }
}
