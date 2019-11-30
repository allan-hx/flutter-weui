import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';
import '../components/title.dart';

Widget box(Widget child) {
  return Padding(
    padding: EdgeInsets.only(left: viewPadding, right: viewPadding, top: viewPadding),
    child: child
  );
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State {
  String value = '';
  GlobalKey inputKey = GlobalKey();
  GlobalKey formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Sample(
      'Input',
      describe: '表单输入',
      showPadding: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextTitle('表单'),
          WeForm(
            key: formKey,
            children: <Widget>[
              WeInput(
                label: '标题标题',
                hintText: '请输入姓名'
              ),
              WeInput(
                label: '标题',
                hintText: '带清除按钮',
                clearable: true
              ),
              WeInput(
                key: inputKey,
                label: '标题',
                hintText: '自定义图标',
                footer: Icon(WeIcons.info, size: 22)
              ),
              WeInput(
                label: '验证码',
                hintText: '请输入验证码',
                footer: WeButton('获取验证码', size: WeButtonSize.mini, theme: WeButtonType.primary)
              ),
              WeInput(
                label: '密码',
                hintText: '请输入密码',
                clearable: true,
                obscureText: true
              ),
              WeInput(
                hintText: '多行文本输入框...',
                maxLines: 4
              )
            ]
          )
        ]
      )
    );
  }
}
