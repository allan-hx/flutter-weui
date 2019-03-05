import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';

class NotifyPage extends StatefulWidget {
  @override
  NotifyPageState createState() => NotifyPageState();
}

class NotifyPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Sample(
      'Drawer',
      describe: '抽屉',
      child: Column(
        children: [
          WeButton('success', theme: WeButtonType.primary, onClick: () {
            WeNotify.success(context)(
              child: Text('我是内容, 可随意布局')
            );
          }),
          SizedBox(height: 20.0),
          WeButton('error', theme: WeButtonType.primary, onClick: () {
            WeNotify.error(context)(
              child: Text('我是内容, 可随意布局')
            );
          }),
          SizedBox(height: 20.0),
          WeButton('自定义', theme: WeButtonType.primary, onClick: () {
            WeNotify.show(context)(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10
                    ),
                    child: Icon(WeIcons.info, color: Colors.white)
                  ),
                  Text('我是内容, 可自定义背景色和内容')
                ]
              )
            );
          })
        ]
      )
    );
  }
}
