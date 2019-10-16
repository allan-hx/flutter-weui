import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';
import '../components/title.dart';

class CollapsePage extends StatefulWidget {
  @override
  CollapsePageState createState() => CollapsePageState();
}

class CollapsePageState extends State {
  @override
  Widget build(BuildContext context) {
    final List<WeCollapseItem> options = [];

    ['1', '2', '3'].forEach((item) {
      options.add(
        WeCollapseItem(
          title: Text('选项$item'),
          child: Text('内容$item')
        )
      );
    });

    return Sample(
      'Collapse',
      showPadding: false,
      describe: '折叠面板',
      child: Column(
        children: <Widget>[
          TextTitle('默认'),
          WeCollapse(
            children: options
          ),
          TextTitle('设置默认展示'),
          WeCollapse(
            defaultActive: ['1'],
            children: options
          ),
          TextTitle('卡片方式'),
          WeCollapse(
            card: true,
            children: options
          ),
          TextTitle('手风琴模式'),
          WeCollapse(
            accordion: true,
            children: options
          ),
          TextTitle('onChange'),
          WeCollapse(
            children: options,
            onChange: (List<String> value) {
              WeToast.info(context)('当前打开的：' + value.toString());
            }
          )
        ]
      )
    );
  }
}
