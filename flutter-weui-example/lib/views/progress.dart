import 'package:flutter/material.dart';
import 'dart:async';
import '../layout/sample.dart';
import 'package:flutter_weui/flutter_weui.dart';
import '../components/title.dart';

class ProgressPage extends StatefulWidget {
  @override
  ProgressState createState() => ProgressState();
}

class ProgressState extends State {
  double value = 0.0;
  Timer timer;

  startUpload() {
    timer?.cancel();
    setState(() {
      value = 0;
    });
    timer = Timer.periodic(Duration(milliseconds: 100), (Timer time) {
      if (value >= 100) {
        timer?.cancel();
        timer = null;
        return;
      }
      setState(() {
        value = value + 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sample(
      'Progress',
      describe: '进度条',
      child: Column(
        children: <Widget>[
          TextTitle('默认', noPadding: true),
          WeProgress(value: value),
          TextTitle('自定义样式', noPadding: true),
          WeProgress(
            value: value,
            height: 6.0,
            decoration: BoxDecoration(
              color: Color(0xffebebeb)
            ),
            higDecoration: BoxDecoration(
              color: Color(0xff26a2ff)
            )
          ),
          TextTitle('左右自定义内容', noPadding: true),
          WeProgress(
            value: value,
            beforeWidget: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text('$value%')
            ),
            afterWidget: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('100%')
            )
          ),
          TextTitle('Icon', noPadding: true),
          WeProgress(
            value: value,
            afterWidget: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(WeIcons.close, color: Colors.red)
            )
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: WeButton('上传', onClick: startUpload)
          )
        ]
      )
    );
  }
}
