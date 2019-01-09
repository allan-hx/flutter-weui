import 'package:flutter/material.dart';
import '../weui/index.dart';
import '../layout/sample.dart';

final Widget box = Container(
  height: 10,
  child: null
);

final Widget rowBox = Container(
  width: 10,
  child: null
);

// 标题
class Title extends StatelessWidget {
  final String title;

  Title(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 8),
        child: Text(title, style: TextStyle(
          fontSize: 16
        ))
      )
    );
  }
}

class ButtonPage extends StatefulWidget {
  @override
  ButtonPageState createState() => ButtonPageState();
}

class ButtonPageState extends State {
  // loading
  bool loading = true;
  bool disabled = true;

  toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build (BuildContext context) {
    return Sample(
      'Button',
      describe: '按钮',
      child: Container(
        child: Column(
          children: <Widget>[
            // 按钮
            Title('按钮'),
            WeButton('default', click: () {
              final duration = Duration(seconds: 1);
              Future.delayed(duration, () {
                print('object');
              });
            }),
            box,
            WeButton(
              'primary',
              theme: WeButtonType.primary
            ),
            box,
            WeButton(
              'warn',
              theme: WeButtonType. warn
            ),
            box,
            Title('disabled 状态'),
            // 禁用状态
            WeButton('default 禁用状态', disabled: disabled),
            box,
            WeButton(
              'warn 禁用状态',
              theme: WeButtonType. warn,
              disabled: disabled
            ),
            box,
            WeButton(
              'primary 禁用状态',
              theme: WeButtonType.primary,
              disabled: disabled
            ),
            box,
            WeButton(
              'primary',
              theme: WeButtonType.primary,
              hollow: true,
              disabled: disabled
            ),
            box,

            Title('loading 状态'),
            WeButton('loading', loading: loading),
            box,
            WeButton(
              'loading',
              theme: WeButtonType.primary,
              loading: loading,
            ),
            box,
            WeButton(
              'loading',
              theme: WeButtonType. warn,
              loading: loading
            ),
            box,
            // box,
            Title('hollow'),
            // hollow
            WeButton(
              'default',
              hollow: true
            ),
            box,
            WeButton(
              'primary',
              theme: WeButtonType.primary,
              hollow: true
            ),
            box,
            WeButton(
              'warn',
              theme: WeButtonType. warn,
              hollow: true
            ),
            box,
            // mini
            Title('mini'),
            Row(
              children: <Widget>[
                WeButton('default', size: WeButtonSize.mini),
                rowBox,
                WeButton(
                  'primary',
                  theme: WeButtonType.primary,
                  size: WeButtonSize.mini
                ),
                rowBox,
                WeButton(
                  'warn',
                  theme: WeButtonType. warn,
                  size: WeButtonSize.mini
                )
              ]
            ),
            box,
            Title('mini loading'),
            Row(
              children: <Widget>[
                WeButton('default', size: WeButtonSize.mini, loading: true),
                rowBox,
                WeButton(
                  'primary',
                  theme: WeButtonType.primary,
                  size: WeButtonSize.mini,
                  loading: true
                ),
                rowBox,
                WeButton(
                  'warn',
                  theme: WeButtonType. warn,
                  size: WeButtonSize.mini,
                  loading: true
                )
              ]
            )
          ]
        )
      )
    );
  }
}
