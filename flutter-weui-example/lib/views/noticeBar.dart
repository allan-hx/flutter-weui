import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import '../layout/sample.dart';
import '../components/title.dart';

final Widget child = Text('请注意：这是一条通知, 通知，通知，通知，通知，通知，通知，通知，通知，通知...');

class NoticeBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sample(
      'NoticeBar',
      describe: '通告栏',
      showPadding: false,
      child: Column(
        children: [
          TextTitle('默认'),
          WeNoticeBar(
            child: child
          ),
          TextTitle('默认'),
          WeNoticeBar(
            child: Text('长度不够, 不滚动...')
          ),
          TextTitle('带图标'),
          WeNoticeBar(
            icon: Icon(Icons.ac_unit, color: Color(0xffed6a0c), size: 18.0),
            child: child
          ),
          TextTitle('可关闭'),
          WeNoticeBar(
            closeable: true,
            child: child
          ),
          TextTitle('自定义widget'),
          WeNoticeBar(
            child: Row(
              children: [
                Icon(Icons.ac_unit, color: Color(0xffed6a0c), size: 18.0),
                Icon(Icons.ac_unit, color: Color(0xffed6a0c), size: 18.0),
                Text('自定义widget'),
                child
              ]
            )
          ),
          TextTitle('自定义颜色和背景'),
          WeNoticeBar(
            child: child,
            fontColor: Color(0xffffffff),
            color: Color(0xffF64E37)
          ),
        ]
      )
    );
  }
}