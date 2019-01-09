import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import '../weui/index.dart';
import '../layout/sample.dart';
import '../components/title.dart';
// import 'package:barcode_scan/barcode_scan.dart';

class SwitchPage extends StatefulWidget {
  @override
  SwitchPageState createState() => SwitchPageState();
}

class SwitchPageState extends State {
  bool open = true;

  // Future scan() async {
  //   final toast = WeToast.info(context);
  //   try {
  //     String barcode = await BarcodeScanner.scan();
  //     toast('二维码内容: $barcode');
  //   } on PlatformException catch (e) {
  //     if (e.code == BarcodeScanner.CameraAccessDenied) {
  //       toast('The user did not grant the camera permission!');
  //     } else {
  //       toast('Unknown error: $e');
  //     }
  //   } catch (e) {
  //     toast('相机打开失败');
  //   }
  // }

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
          WeButton(open ? '关闭' : '打开', theme: WeButtonType.primary, click: () {
            setState(() {
              open = !open;             
            });
          }),
          // WeButton('qrcode', theme: WeButtonType.primary, click: scan)
        ]
      )
    );
  }
}
