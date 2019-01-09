import 'package:flutter/material.dart';
import '../layout/sample.dart';
import '../weui/index.dart';

final list = [
  Text('选项一'),
  Text('选项二'),
  Text('选项三')
];

class ActionsheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WeActionsheetAndroid actionsheetAndroid = WeActionsheet.android(context);
    final WeActionsheetIos actionsheetIos = WeActionsheet.ios(context);

    return Sample(
      'Actionsheet',
      describe: '弹出式菜单',
      child: Column(
        children: <Widget>[
          WeButton('android', theme: WeButtonType.primary, click: () {
            actionsheetAndroid(
              childer: list,
              onChange: (int index) {
                WeToast.info(context)('选择了第${index + 1}个');
              },
              onClose: () {
                WeToast.info(context)('关闭');
              }
            );
          }),
          Container(height: 20.0),
          WeButton('ios', theme: WeButtonType.primary, click: () {
            actionsheetIos(
              title: '请选择',
              childer: list,
              cancelButton: '取消',
              onChange: (int index) {
                WeToast.info(context)('选择了第${index + 1}个');
              },
              onClose: () {
                WeToast.info(context)('关闭');
              }
            );
          }),
          Container(height: 20.0),
          WeButton('ios 无取消按钮', theme: WeButtonType.primary, click: () {
            actionsheetIos(
              title: '请选择',
              childer: list,
              onChange: (int index) {
                WeToast.info(context)('选择了第${index + 1}个');
              },
              onClose: () {
                WeToast.info(context)('关闭');
              }
            );
          }),
          Container(height: 20.0),
          WeButton('android 禁止遮罩层点击', theme: WeButtonType.primary, click: () {
            actionsheetAndroid(
              childer: list,
              maskClosable: false,
              onChange: (int index) {
                WeToast.info(context)('选择了第${index + 1}个');
              },
              onClose: () {
                WeToast.info(context)('关闭');
              }
            );
          }),
          Container(height: 20.0),
          WeButton('ios 禁止遮罩层点击', theme: WeButtonType.primary, click: () {
            actionsheetIos(
              title: '请选择',
              childer: list,
              maskClosable: false,
              cancelButton: '取消',
              onChange: (int index) {
                WeToast.info(context)('选择了第${index + 1}个');
              },
              onClose: () {
                WeToast.info(context)('关闭');
              }
            );
          }),
        ]
      )
    );
  }
}
