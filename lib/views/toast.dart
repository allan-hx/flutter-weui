import 'package:flutter/material.dart';
import '../layout/sample.dart';
import '../weui/index.dart';
import '../components/title.dart';

final Widget rowBox = SizedBox(height: 15);

class ToastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sample(
      'Toast',
      describe: '弹出式提示',
      child: Column(
        children: <Widget>[
          TextTitle('Toast.info', noPadding: true),
          WeButton('default', theme: WeButtonType.primary, click: () {
            WeToast.info(context)('提示');
          }),
          rowBox,
          WeButton('info top', theme: WeButtonType.primary, click: () {
            WeToast.info(context)('提示 - top', align: WeToastInfoAlign.top);
          }),
          rowBox,
          WeButton('info bottom', theme: WeButtonType.primary, click: () {
            WeToast.info(context)('提示 - bottom', align: WeToastInfoAlign.bottom);
          }),
          rowBox,
          WeButton('info 自定义时间', theme: WeButtonType.primary, click: () {
            WeToast.info(context)('5秒消失...', duration: 5000);
          }),
          rowBox,
          WeButton('自定义距离', theme: WeButtonType.primary, click: () {
            WeToast.info(context)(
              '只适合align为top或bottom...',
              align: WeToastInfoAlign.top,
              distance: 250.0
            );
          }),
          rowBox,
          WeButton('带Widget的内容', theme: WeButtonType.primary, click: () {
            WeToast.info(context)(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(WeIcons.loading, color: Colors.white),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('任意内容...')
                  )
                ]
              )
            );
          }),
          rowBox,
          TextTitle('其他提示', noPadding: true),
          WeButton('loading', theme: WeButtonType.primary, click: () {
            final close = WeToast.loading(context)(
              message: '加载中...'
            );
            // 五秒后关闭
            Future.delayed(Duration(milliseconds: 5000), close);
          }),
          rowBox,
          WeButton('loading - 无文字', theme: WeButtonType.primary, click: () {
            WeToast.loading(context)(
              duration: 3000
            );
          }),
          rowBox,
          WeButton('success', theme: WeButtonType.primary, click: () {
            WeToast.success(context)(
              message: '已完成'
            );
          }),
          rowBox,
          WeButton('success - 无文字', theme: WeButtonType.primary, click: () {
            WeToast.success(context)();
          }),
          rowBox,
          WeButton('fail', theme: WeButtonType.primary, click: () {
            WeToast.fail(context)(
              message: '操作失败'
            );
          }),
          rowBox,
          WeButton('fail - 无文字', theme: WeButtonType.primary, click: () {
            WeToast.fail(context)();
          }),
        ]
      )
    );
  }
}
