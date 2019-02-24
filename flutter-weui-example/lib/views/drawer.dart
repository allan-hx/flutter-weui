import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';

class DrawerPage extends StatefulWidget {
  @override
  DrawerPageState createState() => DrawerPageState();
}

class DrawerPageState extends State {
  void show(WeDrawerPlacement placement) {
    weDrawer(context)(
      placement: placement,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('我是内容, 可以随意自定义')
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sample(
      'Drawer',
      describe: '抽屉',
      child: Column(
        children: [
          WeButton('top', theme: WeButtonType.primary, onClick: () {
            show(WeDrawerPlacement.top);
          }),
          SizedBox(height: 20.0),
          WeButton('right', theme: WeButtonType.primary, onClick: () {
            show(WeDrawerPlacement.right);
          }),
          SizedBox(height: 20.0),
          WeButton('bottom', theme: WeButtonType.primary, onClick: () {
            show(WeDrawerPlacement.bottom);
          }),
          SizedBox(height: 20.0),
          WeButton('left', theme: WeButtonType.primary, onClick: () {
            show(WeDrawerPlacement.left);
          }),
          SizedBox(height: 20.0),
          WeButton('无遮罩', theme: WeButtonType.primary, onClick: () {
            Function close;
            close = weDrawer(context)(
              mask: false,
              placement: WeDrawerPlacement.right,
              child: SizedBox(
                width: 300.0,
                child: Align(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: WeButton('关闭', theme: WeButtonType.primary, onClick: () {
                      close();
                    })
                  )
                )
              )
            );
          })
        ]
      )
    );
  }
}
