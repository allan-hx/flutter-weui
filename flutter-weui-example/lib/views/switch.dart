import 'package:flutter/material.dart';
import 'package:flutter_weui/flutter_weui.dart';
import '../layout/sample.dart';
import '../components/title.dart';

class SwitchPage extends StatefulWidget {
  @override
  SwitchPageState createState() => SwitchPageState();
}

class SwitchPageState extends State {
  bool open = true;

  @override
  Widget build(BuildContext context) {
    return Sample(
      'Switch',
      describe: '滑动开关',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitle('默认', noPadding: true),
          WeSwitch(),
          TextTitle('自定义size', noPadding: true),
          WeSwitch(
            size: 20.0
          ),
          TextTitle('自定义颜色', noPadding: true),
          WeSwitch(
            color: Colors.red,
          ),
          TextTitle('禁用', noPadding: true),
          WeSwitch(
            disabled: true,
            checked: true,
          ),
          TextTitle('onChange', noPadding: true),
          WeSwitch(
            onChange: (bool value) {
              WeToast.info(context)(value ? 'open' : 'close');
            }
          ),
          TextTitle('外部控制 - 受控', noPadding: true),
          WeSwitch(
            checked: open,
            onChange: (value) {
              setState(() {
                open = value;   
              });
            }
          ),
          SizedBox(height: 10.0),
          WeButton(open ? '关闭' : '打开', theme: WeButtonType.primary, onClick: () {
            setState(() {
              open = !open;             
            });
          }),
          // WeButton('qrcode', theme: WeButtonType.primary, onClick: scan)
        ]
      )
    );
  }
}
