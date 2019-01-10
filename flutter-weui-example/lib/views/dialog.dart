import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:flutter_weui/flutter_weui.dart';
import '../components/title.dart';

class DialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sample(
      'Dialog',
      describe: '对话框',
      child: Column(
        children: <Widget>[
          TextTitle('ios 主题', noPadding: true),
          WeButton('alert', theme: WeButtonType.primary, onClick: () {
            WeDialog.alert(context)(
              '弹窗内容',
              onConfirm: () {
                WeToast.info(context)('点击了确认');
              }
            );
          }),
          SizedBox(height: 20.0),
          WeButton('alert - 无标题', theme: WeButtonType.primary, onClick: () {
            WeDialog.alert(context)(
              '弹窗内容',
              title: null,
              onConfirm: () {
                WeToast.info(context)('点击了确认');
              }
            );
          }),
          SizedBox(height: 20.0),
          WeButton('confirm', theme: WeButtonType.primary, onClick: () {
            WeDialog.confirm(context)(
              '弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内',
              onCancel: () {
                WeToast.info(context)('点击了取消');
              },
              onConfirm: () {
                WeToast.info(context)('点击了确认');
              }
            );
          }),
          SizedBox(height: 20.0),
          WeButton('confirm - 无标题', theme: WeButtonType.primary, onClick: () {
            WeDialog.confirm(context)(
              '弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内',
              title: null,
              onCancel: () {
                WeToast.info(context)('点击了取消');
              },
              onConfirm: () {
                WeToast.info(context)('点击了确认');
              }
            );
          }),
          SizedBox(height: 20.0),
          TextTitle('android 主题', noPadding: true),
          WeButton('alert', theme: WeButtonType.primary, onClick: () {
            WeDialog.alert(context)(
              '弹窗内容',
              theme: 'android',
              onConfirm: () {
                WeToast.info(context)('点击了确认');
              }
            );
          }),
          SizedBox(height: 20.0),
          WeButton('alert - 无标题', theme: WeButtonType.primary, onClick: () {
            WeDialog.alert(context)(
              '弹窗内容',
              title: null,
              theme: 'android',
              onConfirm: () {
                WeToast.info(context)('点击了确认');
              }
            );
          }),
          SizedBox(height: 20.0),
          WeButton('confirm', theme: WeButtonType.primary, onClick: () {
            WeDialog.confirm(context)(
              '弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内',
              theme: 'android',
              onCancel: () {
                WeToast.info(context)('点击了取消');
              },
              onConfirm: () {
                WeToast.info(context)('点击了确认');
              }
            );
          }),
          SizedBox(height: 20.0),
          WeButton('confirm - 无标题', theme: WeButtonType.primary, onClick: () {
            WeDialog.confirm(context)(
              '弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内',
              theme: 'android',
              title: null,
              onCancel: () {
                WeToast.info(context)('点击了取消');
              },
              onConfirm: () {
                WeToast.info(context)('点击了确认');
              }
            );
          })
        ]
      )
    );
  }
}
