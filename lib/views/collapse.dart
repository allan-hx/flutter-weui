import 'package:flutter/material.dart';
import '../layout/sample.dart';
import '../weui/index.dart';
import '../components/title.dart';

class CollapsePage extends StatefulWidget {
  @override
  CollapsePageState createState() => CollapsePageState();
}

class CollapsePageState extends State {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> options = [];

    ['一', '二', '三'].forEach((item) {
      options.add({
        'title': '选项$item',
        'child': Text('内容$item')
      });
    });

    return Sample(
      'Collapse',
      showPadding: false,
      describe: '折叠面板',
      child: Column(
        children: <Widget>[
          TextTitle('默认'),
          WeCollapse(
            options: options
          ),
          TextTitle('设置默认展示'),
          WeCollapse(
            defaultActive: [0],
            options: options
          ),
          TextTitle('手风琴模式'),
          WeCollapse(
            accordion: true,
            options: options
          )
        ]
      )
    );
  }
}
