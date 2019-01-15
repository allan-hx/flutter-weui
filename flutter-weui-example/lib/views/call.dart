import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:flutter_weui/flutter_weui.dart';

class CallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sample(
      'Cell',
      showPadding: false,
      describe: '列表',
      child: WeCells(
        children: [
          WeCell(
            label: '标题文字'
          ),
          WeCell(
            label: Text('手机号'),
            content: Text('content')
          ),
          WeCell(
            label: Row(
              children: <Widget>[
                Padding(
                  child: Icon(WeIcons.info),
                  padding: EdgeInsets.only(right: 2)
                ),
                Text('标题文字')
              ]
            ),
            content: '带图标的标题'
          ),
          WeCell(
            label: '标题文字',
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  child: Icon(WeIcons.info),
                  padding: EdgeInsets.only(right: 2)
                ),
                Text('带图标的内容')
              ]
            )
          ),
          WeCell(
            label: '带icon',
            content: '内容',
            footer: Icon(WeIcons.clear)
          ),
          WeCell(
            label: '标题文字',
            content: '带点击效果的',
            onClick: () {
              print('click');
            }
          ),
          WeCell(
            label: '自定义内容',
            content: Container(
              child: WeButton('Button', size: WeButtonSize.mini)
            )
          )
        ]
      )
    );
  }
}
