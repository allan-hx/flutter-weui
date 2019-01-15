import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:flutter_weui/flutter_weui.dart';
import '../components/title.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State {
  String value = '0';
  String setpValue = '0';
  String maxValue = '0';
  int changeValue = 10;

  @override
  Widget build(BuildContext context) {
    return Sample(
      'Slider',
      describe: '滑块',
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextTitle('默认', noPadding: true),
            // 默认
            WeSlider(),
            TextTitle('禁用', noPadding: true),
            // 默认
            WeSlider(
              defaultValue: 20,
              disabled: true
            ),
            TextTitle('自定义外观', noPadding: true),
            // 自定义外观
            WeSlider(
              height: 4.0,
              color: Color(0xffa9acb1),
              buttonSize: 30.0,
              higColor: Color(0xff26a2ff)
            ),
            TextTitle('设置max 10 - value:$maxValue', noPadding: true),
            // 默认
            WeSlider(
              max: 10,
              onChange: (value) {
                setState(() {
                  maxValue = value.toString();
                });
              }
            ),
            TextTitle('设置步长 - value:$setpValue', noPadding: true),
            // 默认
            WeSlider(
              step: 10,
              onChange: (value) {
                setState(() {
                  setpValue = value.toString();
                });
              },
            ),
            TextTitle('默认值', noPadding: true),
            // 默认
            WeSlider(
              defaultValue: 40
            ),
            TextTitle('动态修改value - value:$changeValue'),
            // 默认
            WeSlider(
              value: changeValue,
              onChange: (value) {
                setState(() {
                  changeValue = value;               
                });
              }
            ),
            Padding(
              padding: EdgeInsets.only(top: 14.0),
              child: WeButton(
                '设置value为50',
                theme: WeButtonType.primary,
                onClick: () {
                  setState(() {
                    changeValue = 50;                 
                  });
                }
              )
            ),
            TextTitle('onChange value:$value', noPadding: true),
            // 默认
            WeSlider(
              onChange: (curValue) {
                setState(() {
                  value = curValue.toString();
                });
              }
            )
          ]
        )
      )
    );
  }
}
